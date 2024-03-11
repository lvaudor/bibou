#' This function removes entries with the same key in a .bib file and writes a new .bib file
#' @param bibtex_file the path to the .bib file
#' @param suffix the suffix to use to create new .bib file (the new file name will be bibtex_file_\{suffix\}). Defaults to "_clean"
#' @return nothing
#' @examples
#' @export

bib_remove_duplicates <- function(bibtex_file, suffix="_clean") {
  bibtex_data <- readLines(bibtex_file)
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
    dplyr::summarise(firstl=max(first(firstl)-1,1),
              lastl=first(lastl),
              .groups="drop")

  bibtex_file_clean=stringr::str_replace(bibtex_file,
                                         ".bib",
                                         paste0(suffix,".bib"))
  lines=c()
  for (i in 1:nrow(tib)){
    lines=c(lines,
            tib$firstl[i]:tib$lastl[i])
  }
  result=bibtex_data[lines]
  writeLines(bibtex_data[lines],con = bibtex_file_clean)
}
