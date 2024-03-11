#' This function removes entries with the same key in a .bib file and writes a new .bib file
#' @param tib_doc a tib_doc tibble
#' @return a tib_doc tibble with added column LCT (locally cited times)
#' @examples
#' @export

bib_add_LCT <- function(tib_doc) {
  refs=tib_doc$CR
  tib_doc=tib_doc %>%
    dplyr::mutate(LCT=purrr::map_int(.x=id_doc,
                                     ~length(which(stringr::str_detect(refs,.x)))))
  return(tib_doc)
}
