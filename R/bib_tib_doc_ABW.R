#' This function reads bib entries from a .bib file and formats them for later use with package bibou
#' @param tib_doc a tibble with one row=one document
#' @return a tibble with one row = one document*abstract word
#'
#' @export
#' @examples
#' data(tib_doc_Rhone)
#' bib_tib_doc_ABW(tib_doc_Rhone)

bib_tib_doc_ABW<- function(tib_doc) {
  lex_en=mixr::get_lexicon("en")
  tib_doc_ABW=tib_doc %>%
    tidytext::unnest_tokens(word,AB,token="words") %>%
    dplyr::left_join(lex_en,by="word") %>%
    dplyr::mutate(lemma=dplyr::case_when(type %in% c("nom","ver","adj")~lemma,
                                         is.na(type)~ word)) %>%
    dplyr::filter(!is.na(lemma)) %>%
    dplyr::select(id_doc,ABW=lemma,dplyr::everything())
  return(tib_doc_ABW)
}


