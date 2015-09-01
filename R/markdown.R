#' Parse and render markdown text
#'
#' Converts markdown text to several formats using John MacFarlane's \href{https://github.com/jgm/cmark}{cmark}
#' reference implementation. Output in HTML, groff man, CommonMark, and a custom XML format is supported.
#'
#' When smart punctuation is enabled, straight double and single quotes will be rendered as curly quotes,
#' depending on their position. Moreover \code{--} will be rendered as an en-dash, \code{---} will be
#' rendered as an em-dash, and \code{...} will be rendered as ellipses.
#'
#' @useDynLib commonmark R_render_markdown
#' @aliases commonmark markdown
#' @export
#' @rdname commonmark
#' @name commonmark
#' @param text Markdown text
#' @param sourcepos Include source position attribute in output.
#' @param hardbreaks Treat newlines as hard line breaks. If this option is specified, hard wrapping is disabled
#' regardless of the value given with \code{width}.
#' @param smart Use smart punctuation. See details.
#' @param normalize Consolidate adjacent text nodes.
#' @param width Specify wrap width (default 0 = nowrap).
#' @examples md <- readLines(curl::curl("https://raw.githubusercontent.com/yihui/knitr/master/NEWS.md"))
#' html <- markdown_html(md)
#' xml <- markdown_xml(md)
#' man <- markdown_man(md)
#' tex <- markdown_latex(md)
#' cm <- markdown_commonmark(md)
markdown_html <- function(text, hardbreaks = FALSE, smart = FALSE, normalize = FALSE, sourcepos = FALSE){
  text <- enc2utf8(paste(text, collapse="\n"))
  .Call(R_render_markdown, text, 1L, sourcepos, hardbreaks, smart, normalize, 0L)
}

#' @export
#' @rdname commonmark
markdown_xml <- function(text, hardbreaks = FALSE, smart = FALSE, normalize = FALSE, sourcepos = FALSE){
  text <- enc2utf8(paste(text, collapse="\n"))
  .Call(R_render_markdown, text, 2L, sourcepos, hardbreaks, smart, normalize, 0L)
}

#' @export
#' @rdname commonmark
markdown_man <- function(text, hardbreaks = FALSE, smart = FALSE, normalize = FALSE, width = 0){
  text <- enc2utf8(paste(text, collapse="\n"))
  .Call(R_render_markdown, text, 3L, FALSE, hardbreaks, smart, normalize, as.integer(width))
}

#' @export
#' @rdname commonmark
markdown_commonmark <- function(text, hardbreaks = FALSE, smart = FALSE, normalize = FALSE, width = 0){
  text <- enc2utf8(paste(text, collapse="\n"))
  .Call(R_render_markdown, text, 4L, FALSE, hardbreaks, smart, normalize, as.integer(width))
}

#' @export
#' @rdname commonmark
markdown_latex <- function(text, hardbreaks = FALSE, smart = FALSE, normalize = FALSE, width = 0){
  text <- enc2utf8(paste(text, collapse="\n"))
  .Call(R_render_markdown, text, 5L, FALSE, hardbreaks, smart, normalize, as.integer(width))
}
