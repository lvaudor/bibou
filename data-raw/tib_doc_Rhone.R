bibtex_file=system.file("savedrecs_Rhone.bib",package="bibou")
bib_remove_duplicates(bibtex_file,to_file="data-raw/savedrecs_Rhone_clean.bib")
tib_doc_Rhone=bib_tib_doc("data-raw/savedrecs_Rhone_clean.bib",add_LC=TRUE)
usethis::use_data(tib_doc_Rhone)
