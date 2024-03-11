#' This function reads bib entries from a .bib file and formats them for later use with package bibou
#' @param tib_doc a tibble with one row=one document
#' @return a tibble with one row = one document*author
#' @examples
#' bibtex_file=system.file("savedrecs_Rhone.bib",package="bibou")
#' tib_doc=bib_tib_doc(bibtex_file)
#' bib_tib_doc_author(tib_doc)
#' @export

bib_tib_doc_author<- function(tib_doc) {
  tib_doc_author=tib_doc %>%
    tidytext::unnest_tokens(output="AU",
                  input="AU",
                  token=stringr::str_split,
                  pattern = ";",
                  to_lower=FALSE) %>%
    dplyr::group_by(id_doc) %>%
    dplyr::mutate(AU_rank=1:n()) %>%
    dplyr::ungroup() %>%
    dplyr::select(id_doc,AU,AU_rank,everything())
  return(tib_doc_author)
}
