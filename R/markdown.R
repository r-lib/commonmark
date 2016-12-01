#' Parse and render markdown text
#'
#' Converts markdown text to several formats using John MacFarlane's [cmark](https://github.com/jgm/cmark)
#' reference implementation. Output in HTML, groff man, CommonMark, and a custom XML format is supported.
#'
#' Support for extensions is provided via the Github [fork](https://github.com/github/cmark) of cmark.
#' See also the manual page on [extensions].
#'
#' When smart punctuation is enabled, straight double and single quotes will be rendered as curly quotes,
#' depending on their position. Moreover `--` will be rendered as an en-dash, `---`` will be
#' rendered as an em-dash, and `...` will be rendered as ellipses.
#'
#' @useDynLib commonmark R_render_markdown
#' @aliases commonmark markdown
#' @export
#' @rdname commonmark
#' @name commonmark
#' @param text Markdown text
#' @param sourcepos Include source position attribute in output.
#' @param hardbreaks Treat newlines as hard line breaks. If this option is specified, hard wrapping is disabled
#' regardless of the value given with `width`.
#' @param smart Use smart punctuation. See details.
#' @param normalize Consolidate adjacent text nodes.
#' @param extensions Enables Github extensions. Can be `TRUE` (all) `FALSE` (none) or a character
#' vector with a subset of available [extensions][list_extension].
#' @param width Specify wrap width (default 0 = nowrap).
#' @examples md <- readLines(curl::curl("https://raw.githubusercontent.com/yihui/knitr/master/NEWS.md"))
#' html <- markdown_html(md)
#' xml <- markdown_xml(md)
#' man <- markdown_man(md)
#' tex <- markdown_latex(md)
#' cm <- markdown_commonmark(md)
markdown_html <- function(text, hardbreaks = FALSE, smart = FALSE, normalize = FALSE, sourcepos = FALSE, extensions = FALSE){
  text <- enc2utf8(paste(text, collapse="\n"))
  extensions <- get_extensions(extensions)
  .Call(R_render_markdown, text, 1L, sourcepos, hardbreaks, smart, normalize, 0L, extensions)
}

#' @export
#' @rdname commonmark
markdown_xml <- function(text, hardbreaks = FALSE, smart = FALSE, normalize = FALSE, sourcepos = FALSE, extensions = FALSE){
  text <- enc2utf8(paste(text, collapse="\n"))
  extensions <- get_extensions(extensions)
  .Call(R_render_markdown, text, 2L, sourcepos, hardbreaks, smart, normalize, 0L, extensions)
}

#' @export
#' @rdname commonmark
markdown_man <- function(text, hardbreaks = FALSE, smart = FALSE, normalize = FALSE, width = 0, extensions = FALSE){
  text <- enc2utf8(paste(text, collapse="\n"))
  extensions <- get_extensions(extensions)
  .Call(R_render_markdown, text, 3L, FALSE, hardbreaks, smart, normalize, as.integer(width), extensions)
}

#' @export
#' @rdname commonmark
markdown_commonmark <- function(text, hardbreaks = FALSE, smart = FALSE, normalize = FALSE, width = 0, extensions = FALSE){
  text <- enc2utf8(paste(text, collapse="\n"))
  extensions <- get_extensions(extensions)
  .Call(R_render_markdown, text, 4L, FALSE, hardbreaks, smart, normalize, as.integer(width), extensions)
}

#' @export
#' @rdname commonmark
markdown_latex <- function(text, hardbreaks = FALSE, smart = FALSE, normalize = FALSE, width = 0, extensions = FALSE){
  text <- enc2utf8(paste(text, collapse="\n"))
  extensions <- get_extensions(extensions)
  .Call(R_render_markdown, text, 5L, FALSE, hardbreaks, smart, normalize, as.integer(width), extensions)
}
