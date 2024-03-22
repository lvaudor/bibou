#' This function reads bib entries from a .bib file and formats them for later use with package bibou
#' @param tib_doc a tibble with one row=one document
#' @return a tibble with one row = one document*CR
#' @examples
#' data(tib_doc_Rhone)
#' tib_doc_CR=bib_tib_doc_CR(tib_doc_Rhone)
#' @export

bib_tib_doc_CR<- function(tib_doc) {
  tib_doc_keyword=tib_doc %>%
    tidytext::unnest_tokens(output="CR",
                            input="CR",
                            token=stringr::str_split,
                            pattern = "; ",
                            to_lower=FALSE) %>%
    dplyr::group_by(id_doc) %>%
    dplyr::ungroup() %>%
    dplyr::select(id_doc,CR,everything()) %>%
    dplyr::filter(!is.na(CR))
  return(tib_doc_keyword)
}
