#' This function reads bib entries from a .bib file and formats them for later use with package bibou
#' @param bibtex_file the path to the .bib file
#' @param check_in_text filter docs to keep only those with this pattern in either title, keywords, or abstract. Defaults to NULL.
#' @return a tibble with one row = one document
#' @examples
#' bibtex_file=system.file("savedrecs_Rhone.bib",package="bibou")
#' bib_tib_doc(bibtex_file)
#' @export

bib_tib_doc <- function(bibtex_file, check_in_text=NULL, add_LC=TRUE){
  tib_doc=bibliometrix::convert2df(file = bibtex_file,
                  dbsource = "isi",
                  format = "bibtex")%>%
        dplyr::mutate(DE=stringr::str_replace_all(DE,";;",";")) %>%
        tibble::rownames_to_column(var="id_doc") %>%
        tibble::as_tibble()
    if(!is.null(check_in_text)){
       tib_doc=tib_doc %>%
        tidyr::unite(texts,TI,AB,DE,
                     sep="; ",remove=FALSE) %>%
        dplyr::mutate(check=str_detect(texts,check_in_text)) %>%
        dplyr::filter(check) %>%
        dplyr::select(-texts,check)
    }
   if(add_LC){
     tib_doc=tib_doc %>%
       dplyr::mutate(LC=purrr::map_int(id_doc,
                                       ~length(which(stringr::str_detect(tib_doc$CR,.x)))))
   }
  return(tib_doc)
}
