#define HAVE_STDBOOL_H

#ifdef HAVE_STDBOOL_H
  #include <stdbool.h>
#elif !defined(__cplusplus)
  typedef char bool;
#endif

#if !(defined(__sun) && defined(__SVR4))
#define HAVE___BUILTIN_EXPECT
#endif

#ifndef _WIN32
#define HAVE_C99_SNPRINTF
#endif

#define HAVE___ATTRIBUTE__

#ifdef HAVE___ATTRIBUTE__
  #define CMARK_ATTRIBUTE(list) __attribute__ (list)
#else
  #define CMARK_ATTRIBUTE(list)
#endif

#define HAVE_VA_COPY

#ifndef HAVE_VA_COPY
  #define va_copy(dest, src) ((dest) = (src))
#endif
