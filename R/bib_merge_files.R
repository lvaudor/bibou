#' This function merges entries from several .bib files into a single .bib file
#' @param from_files the paths to the exported files
#' @param to_file the path to the single merged .bib file. Defaults to "savedrecs_merged.bib" the suffix to use to create new .bib file (the new file name will be bibtex_file_\{suffix\}). Defaults to "_clean"
#' @return nothing
#' @examples
#' bibtex_file_1=system.file("savedrecs(1).bib",package="bibou")
#' bibtex_files=purrr::map_chr(as.character(1:5),~stringr::str_replace(bibtex_file_1,"1(?=\\).bib)",.x))
#' bib_merge_files(from_files=bibtex_files,to_file="data-raw/savedrecs_merged.bib")
#' @export

bib_merge_files <- function(from_files, to_file="savedrecs_merged.bib") {
  bibtex_data=purrr::map(from_files,readLines) %>% unlist()
  writeLines(bibtex_data,con = to_file)
}
