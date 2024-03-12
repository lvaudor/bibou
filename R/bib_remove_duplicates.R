#' This function removes entries with the same key in a .bib file and writes a new .bib file
#' @param from_file the path to the .bib file
#' @param to_file the file with no duplicates created
#' @return nothing
#' @examples
#' @export

bib_remove_duplicates <- function(from_file, to_file="savedrecs_clean.bib") {
  bibtex_data <- readLines(from_file)
  # Create tibble with 1 line = 1 bib entry
  tib=tibble::tibble(
    # Detect first and last lines of bib entries
    firstl=bibtex_data %>%
      stringr::str_detect("^@") %>% which(),
    lastl=bibtex_data %>%
      stringr::str_detect("^\\}$") %>% which(),
    key=stringr::str_extract(bibtex_data[firstl],"(?<=\\{\\s).*(?=,)")
  ) %>%
    dplyr::group_by(key) %>%
    # For each key keep only lines corresponding to first bib entry
    dplyr::summarise(firstl=max(dplyr::first(firstl)-1,1),
                     lastl=dplyr::first(lastl),
                     .groups="drop")
  lines=c()
  for (i in 1:nrow(tib)){
    lines=c(lines,
            tib$firstl[i]:tib$lastl[i])
  }
  result=bibtex_data[lines]
  writeLines(bibtex_data[lines],con = to_file)
}
