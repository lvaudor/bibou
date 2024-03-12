# bibou <img src="man/figures/logo.png" align="right" height="139" alt="" />

This package aims at formatting and using bibliographic data to produce
a statistical and graphical analysis of a bibliometric corpus.

The bibou package can be used to format bibliographic exports from web
of science. It helps formatting these exports into tables, either with:

-   **tib\_doc**: one row per document,
-   **tib\_doc\_author**: one row per document\*author,
-   **tib\_doc\_keyword**: one row per document\*keyword
-   **tib\_doc\_word**: one row per document\*word of abstract

The articles in the documentation then show how these tables can be used
to produce bibliometric tables or graphics based on the `tidyverse` set
of tools.

It builds on packages `bibliometrix`, `tidytext`, and `mixr`.

# Installation

Please install the bibou package with

    remotes::install_github("lvaudor/bibou")

<!-- ```{r build_index, include=FALSE} -->
<!-- rmarkdown::render("README.Rmd",output_format="md_document",output_file="index.md") -->
<!-- pkgdown::build_home() -->
<!-- ``` -->
