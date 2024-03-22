#' This function reads bib entries from a .bib file and formats them for later use with package bibou
#' @param tib_doc a tibble with one row=one document
#' @return a tibble with one row = one document*keyword
#'
#' @export
#' @examples
#' data(tib_doc_Rhone)
#' bib_tib_doc_DE(tib_doc)

bib_tib_doc_DE<- function(tib_doc) {
  tib_doc_DE=tib_doc %>%
    tidytext::unnest_tokens(output="DE",
                  input="DE",
                  token=stringr::str_split,
                  pattern = ";",
                  to_lower=FALSE) %>%
    dplyr::group_by(id_doc) %>%
    dplyr::ungroup() %>%
    dplyr::select(id_doc,DE,everything()) %>%
    dplyr::mutate(DE=stringr::str_replace(DE,"^ ","")) %>%
    dplyr::filter(!is.na(DE))
  return(tib_doc_DE)
}
