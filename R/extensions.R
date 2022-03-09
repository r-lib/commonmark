#' Github CommonMark Extensions
#'
#' The Github fork of cmark supports several markdown extensions which provide
#' features which are not (yet) in the official commonmark spec.
#'
#' Currently the following extensions are supported:
#'
#'  - **table** support rendering of tables: [gfm-spec section 4.10](https://github.github.com/gfm/#tables-extension-)
#'  - **strikethrough** via `~sometext~` syntax: [gfm-spec section 6.5](https://github.github.com/gfm/#strikethrough-extension-)
#'  - **autolink** automatically turn URLs into hyperlinks: [gfm-spec section 6.9](https://github.github.com/gfm/#autolinks-extension-)
#'  - **tagfilter** blacklist html tags: `title` `textarea` `style` `xmp` `iframe`
#' `noembed` `noframes` `script` `plaintext`: [gfm-spec section 6.11](https://github.github.com/gfm/#disallowed-raw-html-extension-)
#'  - **tasklist** turns certain list items into checkboxes: [gfm-spec section 5.3](https://github.github.com/gfm/#task-list-items-extension-)
#'
#' See the full spec for [GitHub Flavored Markdown](https://github.github.com/gfm/).
#'
#' @export
#' @name extensions
#' @rdname extensions
#' @useDynLib commonmark R_list_extensions
#' @examples print(list_extensions())
list_extensions <- function(){
  .Call(R_list_extensions)
}

get_extensions <- function(x){
  if(identical(x, FALSE))
    return(NULL)
  exts <- list_extensions()
  if(isTRUE(x))
    return(exts)
  found <- match(x, exts)
  unfound <- is.na(found)
  if(any(unfound)){
    stop("Invalid commonmark extensions: ", paste(x[unfound], collapse = ", "), call. = FALSE)
  }
  return(x)
}

