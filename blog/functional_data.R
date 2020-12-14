#' ---
#' title: Functional data structures (mostly from Hadley Wickham or Thomas Mailund)
#' output:
#'    html_document:
#'      toc: true
#'      highlight: zenburn
#' ---
#' <!-- rmarkdown::render("supervised_play/nice_code.R") -->
#' <!-- [See here.](http://brooksandrew.github.io/simpleblog/articles/render-reports-directly-from-R-scripts/) -->
#+ setup, eval=FALSE


#'# 1. Introduction
#'
#'In functional languages, and as a general rule in the R programming language,
#'data is not mutable. You cannot alter existing data. The techniques used to
#'modify data structures to give us efficient building blocks for algorithmic
#'programming cannot be used.
#'
#'R is not a *pure* functional language, and we can change variable-value
#'bindings by modifying environments.
#'
#'
#'# 3. Immutable data
#'
#'What prevents us from implementing traditional imperative-language data
#'structures in R is the immutability of data. As a general rule, you can modify
#'environments—so you can assign to variables—but you cannot modify actual data.
#'Whenever R makes it look like you are changing data, it is lying.
#'
#'R is not entirely side-effect free, as a programming language, but side
#'effects are contained to I/O, random number generation, and affecting
#'variable-value bindings in environments.
#'
#'Modifying actual data is not something we can do via function side effects.1
#'If we want to update a data structure, we have to do what R does when we try
#'to modify data: we need to build a new data structure, looking like the one we
#'wanted to change the old one into. Functions that should update data
#'structures need to construct new versions and return them to the caller.
#'
#'## Persistent structures
#'
#'
# When we update an imperative data structure we typically accept that the old version of the data structure will no longer be
#'available, but when we update a functional data structure, we expect that both
#'the old and new versions of the data structure will be available for further
#'processing. A data structure that supports multiple versions is called persistent, whereas a data structure that allows only a single version at a time is called ephemeral. What we get out of immutable data is persistent data structures; these are the natural data structures in R.
#'
#'
#'Most books on data structures assume an imperative language like C or C++. However, data structures for these languages do not always translate well to functional languages such as Standard ML, Haskell, or Scheme 