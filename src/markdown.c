#include <Rinternals.h>
#include <cmark_export.h>
#include <cmark.h>
#include <string.h>

SEXP R_markdown_html(SEXP text, SEXP options){
  const char *input = CHAR(STRING_ELT(text, 0));
  return mkString(cmark_markdown_to_html(input, strlen(input), asInteger(options)));
}

SEXP R_markdown_xml(SEXP text, SEXP options){
  const char *input = CHAR(STRING_ELT(text, 0));
  cmark_node *doc = cmark_parse_document(input, strlen(input), asInteger(options));
  char *result = cmark_render_xml(doc, asInteger(options));
  cmark_node_free(doc);
  return mkString(result);
}

SEXP R_markdown_man(SEXP text, SEXP options){
  const char *input = CHAR(STRING_ELT(text, 0));
  cmark_node *doc = cmark_parse_document(input, strlen(input), asInteger(options));
  char *result = cmark_render_man(doc, asInteger(options));
  cmark_node_free(doc);
  return mkString(result);
}

SEXP R_markdown_cm(SEXP text, SEXP options, SEXP width){
  const char *input = CHAR(STRING_ELT(text, 0));
  cmark_node *doc = cmark_parse_document(input, strlen(input), asInteger(options));
  char *result = cmark_render_commonmark(doc, asInteger(options), asInteger(width));
  cmark_node_free(doc);
  return mkString(result);
}
