/** cmark binding for R by Jeroen Ooms (2016)
 *  Adapted from CLI in main.c
 *  NOTE: man(3) states that cmark assumes UTF-8 for both input and output
 */

#include <Rinternals.h>
#include <stdlib.h>
#include "cmark-gfm.h"

/* Github extensions */
#include "extensions/cmark-gfm-core-extensions.h"
#include "registry.h"

typedef enum {
  FORMAT_NONE,
  FORMAT_HTML,
  FORMAT_XML,
  FORMAT_MAN,
  FORMAT_COMMONMARK,
  FORMAT_PLAINTEXT,
  FORMAT_LATEX
} writer_format;

static char* print_document(cmark_node *document, writer_format writer, int options, int width){
  switch (writer) {
  case FORMAT_HTML:
    return cmark_render_html(document, options, NULL);
  case FORMAT_XML:
    return cmark_render_xml(document, options);
  case FORMAT_MAN:
    return cmark_render_man(document, options, width);
  case FORMAT_COMMONMARK:
    return cmark_render_commonmark(document, options, width);
  case FORMAT_LATEX:
    return cmark_render_latex(document, options, width);
  case FORMAT_PLAINTEXT:
    return cmark_render_plaintext(document, options, width);
  default:
    Rf_error("Unknown output format %d", writer);
  }
}

SEXP R_render_markdown(SEXP text, SEXP format, SEXP sourcepos, SEXP hardbreaks, SEXP smart, SEXP normalize, SEXP width, SEXP extensions) {

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

  /* parse input */
  SEXP input = STRING_ELT(text, 0);
  cmark_parser *parser = cmark_parser_new(options);
  for(int i = 0; i < Rf_length(extensions); i++){
    cmark_syntax_extension *syntax_extension = cmark_find_syntax_extension(CHAR(STRING_ELT(extensions, i)));
    if(!syntax_extension)
      Rf_error("Failed to find load 'table' extension");
    cmark_parser_attach_syntax_extension(parser, syntax_extension);
  }
  cmark_parser_feed(parser, CHAR(input), LENGTH(input));
  cmark_node *doc = cmark_parser_finish(parser);
  cmark_parser_free(parser);

  /* render output format */
  char *output = print_document(doc, asInteger(format), options, asInteger(width));
  cmark_node_free(doc);

  /* cmark always returns UTF8 output */
  SEXP res = PROTECT(allocVector(STRSXP, 1));
  SET_STRING_ELT(res, 0, Rf_mkCharCE(output, CE_UTF8));
  UNPROTECT(1);
  free(output);
  return res;
}
