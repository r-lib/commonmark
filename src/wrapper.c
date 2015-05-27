/** cmark binding for R by Jeroen Ooms (2015)
 *  Adapted from CLI in main.c
 *  NOTE: man(3) states that cmark assumes UTF-8 for both input and output
 */

#include <Rinternals.h>
#include <stdlib.h>
#include <string.h>
#include "cmark.h"

typedef enum {
  FORMAT_NONE,
  FORMAT_HTML,
  FORMAT_XML,
  FORMAT_MAN,
  FORMAT_COMMONMARK
} writer_format;

char* print_document(cmark_node *document, writer_format writer, int options, int width){
  switch (writer) {
  case FORMAT_HTML:
    return cmark_render_html(document, options);
  case FORMAT_XML:
    return cmark_render_xml(document, options);
  case FORMAT_MAN:
    return cmark_render_man(document, options);
  case FORMAT_COMMONMARK:
    return cmark_render_commonmark(document, options, width);
  default:
    Rf_error("Unknown output format %d", writer);
  }
}

SEXP R_render_markdown(SEXP text, SEXP format, SEXP sourcepos, SEXP hardbreaks, SEXP smart, SEXP normalize, SEXP width) {

  /* input validation */
  if(!isString(text))
    error("Argument 'text' must be string.");
  if(!isInteger(format))
    error("Argument 'format' must be integer.");
  if(!isLogical(sourcepos))
    error("Argument 'sourcepos' must be logical.");
  if(!isLogical(hardbreaks))
    error("Argument 'hardbreaks' must be logical.");
  if(!isLogical(smart))
    error("Argument 'smart' must be logical.");
  if(!isLogical(normalize))
    error("Argument 'normalize' must be logical.");
  if(!isInteger(width))
    error("Argument 'width' must be integer.");

  /* combine options */
  int options = CMARK_OPT_DEFAULT;
  options += asLogical(sourcepos) * CMARK_OPT_SOURCEPOS;
  options += asLogical(hardbreaks) * CMARK_OPT_HARDBREAKS;
  options += asLogical(smart) * CMARK_OPT_SMART;
  options += asLogical(normalize) * CMARK_OPT_NORMALIZE;

  /* render output */
  const char *input = translateCharUTF8(STRING_ELT(text, 0));
  cmark_node *doc = cmark_parse_document(input, strlen(input), options);
  char *output = print_document(doc, asInteger(format), options, asInteger(width));
  SEXP res = PROTECT(allocVector(STRSXP, 1));
  SET_STRING_ELT(res, 0, Rf_mkCharCE(output, CE_UTF8));
  UNPROTECT(1);
  cmark_node_free(doc);
  free(output);
  return res;
}
