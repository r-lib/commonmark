# commonmark

##### *Bindings to the CommonMark Reference Implementation*

[![Build Status](https://travis-ci.org/jeroenooms/commonmark.svg?branch=master)](https://travis-ci.org/jeroenooms/commonmark)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/jeroenooms/commonmark?branch=master&svg=true)](https://ci.appveyor.com/project/jeroenooms/commonmark)
[![Coverage Status](https://codecov.io/github/jeroenooms/commonmark/coverage.svg?branch=master)](https://codecov.io/github/jeroenooms/commonmark?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/commonmark)](http://cran.r-project.org/package=commonmark)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/commonmark)](http://cran.r-project.org/web/packages/commonmark/index.html)
[![Github Stars](https://img.shields.io/github/stars/jeroenooms/commonmark.svg?style=social&label=Github)](https://github.com/jeroenooms/commonmark)

> The CommonMark specification defines a rationalized version of markdown
  syntax. This package uses the libcmark reference implementation for converting
  markdown text into various formats including html, latex and groff man. In
  addition it exposes the markdown parse tree in xml format.

## Documentation

About the R package:

 - Blog post: [Commonmark: Super Fast Markdown Rendering in R](https://www.opencpu.org/posts/commonmark-fast/)

Other resources:

 - [CommonMark specification for Markdown text](http://commonmark.org/help/)

## Hello World

```r
library(commonmark)

# Get some markdown data
md <- readLines(curl::curl("https://raw.githubusercontent.com/yihui/knitr/master/NEWS.md"))

# Convert it into formats formats
html <- markdown_html(md)
xml <- markdown_xml(md)
man <- markdown_man(md)
tex <- markdown_latex(md)
cm <- markdown_commonmark(md)
```
