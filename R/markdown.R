#' Parse and render markdown text
#'
#' Converts markdown text to several formats using John MacFarlane's \href{https://github.com/jgm/cmark}{cmark}
#' reference implementation. Output in HTML, groff man, CommonMark, and a custom XML format is supported.
#'
#' @useDynLib commonmark R_render_markdown
#' @aliases commonmark markdown
#' @export
#' @rdname commonmark
#' @name commonmark
#' @param text Markdown text
#' @param sourcepos Include source position attribute
#' @param hardbreaks Treat newlines as hard line breaks
#' @param smart Use smart punctuation
#' @param normalize Consolidate adjacent text nodes
#' @param width Specify wrap width (default 0 = nowrap)
#' @examples library(curl)
#' md <- readLines(curl("https://raw.githubusercontent.com/yihui/knitr/master/NEWS.md"))
#' html <- markdown_html(md)
#' xml <- markdown_xml(md)
#' man <- markdown_man(md)
#' cm <- markdown_commonmark(md)
markdown_html <- function(text, sourcepos = FALSE, hardbreaks = FALSE, smart = FALSE, normalize = FALSE){
  .Call(R_render_markdown, paste(text, collapse="\n"), 1L, sourcepos, hardbreaks, smart, normalize, 0L)
}

#' @export
#' @rdname commonmark
markdown_xml <- function(text, sourcepos = FALSE, hardbreaks = FALSE, smart = FALSE, normalize = FALSE){
  .Call(R_render_markdown, paste(text, collapse="\n"), 2L, sourcepos, hardbreaks, smart, normalize, 0L)
}

#' @export
#' @rdname commonmark
markdown_man <- function(text, sourcepos = FALSE, hardbreaks = FALSE, smart = FALSE, normalize = FALSE){
  .Call(R_render_markdown, paste(text, collapse="\n"), 3L, sourcepos, hardbreaks, smart, normalize, 0L)
}

#' @export
#' @rdname commonmark
markdown_commonmark <- function(text, sourcepos = FALSE, hardbreaks = FALSE, smart = FALSE, normalize = FALSE, width = 0){
  .Call(R_render_markdown, paste(text, collapse="\n"), 4L, sourcepos, hardbreaks, smart, normalize, as.integer(width))
}
