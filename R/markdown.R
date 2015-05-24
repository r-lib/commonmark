#' Convert markdown to HTML
#'
#' Convert markdown text to HTML using John MacFarlane's \href{https://github.com/jgm/cmark}{cmark}
#' reference implementation.
#'
#' @useDynLib commonmark R_markdown_html
#' @export
#' @rdname markdown
#' @param text markdown text
#' @param options integer with options
#' @param width width of the commonmark output
#' @examples library(curl)
#' md <- readLines(curl("https://raw.githubusercontent.com/yihui/knitr/master/NEWS.md"))
#' html <- markdown_html(md)
#' xml <- markdown_xml(md)
#' man <- markdown_man(md)
#' cm <- markdown_cm(md)
markdown_html <- function(text, options = 8L){
  .Call(R_markdown_html, paste(text, collapse="\n"), options)
}

#' @useDynLib commonmark R_markdown_xml
#' @export
#' @rdname markdown
markdown_xml <- function(text, options = 8L){
  .Call(R_markdown_xml, paste(text, collapse="\n"), options)
}

#' @useDynLib commonmark R_markdown_man
#' @export
#' @rdname markdown
markdown_man <- function(text, options = 8L){
  .Call(R_markdown_man, paste(text, collapse="\n"), options)
}


#' @useDynLib commonmark R_markdown_cm
#' @export
#' @rdname markdown
markdown_cm <- function(text, options = 8L, width = 100L){
  .Call(R_markdown_cm, paste(text, collapse="\n"), options, width)
}
