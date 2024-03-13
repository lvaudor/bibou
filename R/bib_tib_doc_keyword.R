#' This function reads bib entries from a .bib file and formats them for later use with package bibou
#' @param tib_doc a tibble with one row=one document
#' @return a tibble with one row = one document*keyword
#' @examples
#' bibtex_file=system.file("savedrecs_Rhone.bib",package="bibou")
#' tib_doc=bib_tib_doc(bibtex_file)
#' bib_tib_doc_keyword(tib_doc)
#' @export

bib_tib_doc_keyword<- function(tib_doc) {
  tib_doc_keyword=tib_doc %>%
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
  return(tib_doc_keyword)
}
