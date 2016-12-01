/* List Available Github extensions */
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
#include "extensions/core-extensions.h"
#include "syntax_extension.h"
#include "registry.h"

void R_init_commonmark(DllInfo *info) {
  cmark_register_plugin(core_extensions_registration);
}

SEXP R_list_extensions(){
  cmark_mem *mem = cmark_get_default_mem_allocator();
  cmark_llist *syntax_extensions = cmark_list_syntax_extensions(mem);
  cmark_llist *tmp = syntax_extensions;
  int len;
  for(len = 0; tmp != NULL;len++){
    tmp = tmp->next;
  }
  SEXP out = allocVector(STRSXP, len);
  int i = 0;
  for (tmp = syntax_extensions; tmp; tmp=tmp->next) {
    cmark_syntax_extension *ext = tmp->data;
    SET_STRING_ELT(out, i, mkChar(ext->name));
    i++;
  }
  cmark_llist_free(mem, syntax_extensions);
  return out;
}
