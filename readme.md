# commonmark

> High Performance CommonMark and Github Markdown Rendering in R

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/commonmark)](http://cran.r-project.org/package=commonmark)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/commonmark)](http://cran.r-project.org/web/packages/commonmark/index.html)
[![Github Stars](https://img.shields.io/github/stars/jeroen/commonmark.svg?style=social&label=Github)](https://github.com/jeroen/commonmark)

The CommonMark specification defines a rationalized version of markdown
syntax. This package uses the 'cmark' reference implementation for converting
markdown text into various formats including html, latex and groff man. In
addition it exposes the markdown parse tree in xml format. The latest version of
this package also adds support for Github extensions including tables, autolinks
and strikethrough text.

## Documentation



About the R package:

 - Blog post: [High Performance CommonMark and Github Markdown Rendering in R](https://ropensci.org/blog/blog/2016/12/02/commonmark)

Other resources:

 - [CommonMark specification for Markdown text](http://commonmark.org/help/)

## Basic Markdown


```r
library(commonmark)
md <- "## Test
An *example* text for the `commonmark` package."

# Convert to Latex
cat(markdown_latex(md))
```

```
\subsection{Test}

An \emph{example} text for the \texttt{commonmark} package.
```

```r
# Convert to HTML
cat(markdown_html(md))
```

```
<h2>Test</h2>
<p>An <em>example</em> text for the <code>commonmark</code> package.</p>
```

```r
# Convert to 'groff' man 
cat(markdown_man(md))
```

```
.SS
Test
.PP
An \f[I]example\f[] text for the \f[C]commonmark\f[] package.
```

```r
# Convert back to (normalized) markdown
cat(markdown_commonmark(md))
```

```
## Test

An *example* text for the `commonmark` package.
```

```r
# The markdown parse tree
cat(markdown_xml(md))
```

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE document SYSTEM "CommonMark.dtd">
<document xmlns="http://commonmark.org/xml/1.0">
  <heading level="2">
    <text>Test</text>
  </heading>
  <paragraph>
    <text>An </text>
    <emph>
      <text>example</text>
    </emph>
    <text> text for the </text>
    <code>commonmark</code>
    <text> package.</text>
  </paragraph>
</document>
```

## Github Extensions

Commonmark includes several 'extensions' to enable features which are not (yet) part of the official specification. The current version of the commonmark R package offers 4 such extensions:

 - __table__ support rendering of tables
 - __strikethough__ via `~sometext~` syntax
 - __autolink__ automatically turn URLs into hyperlinks
 - __tagfilter__ blacklist html tags: `title` `textarea` `style` `xmp` `iframe` `noembed` `noframes` `script` `plaintext`.
 
These extensions were added by Github to support GitHub Flavored Markdown.


```r
table <- '
aaa | bbb | ccc | ddd | eee
:-- | --- | :-: | --- | --:
fff | ggg | hhh | iii | jjj'

cat(markdown_latex(table, extensions = TRUE))
```

```
\begin{table}
\begin{tabular}{llclr}
aaa & bbb & ccc & ddd & eee \\
fff & ggg & hhh & iii & jjj \\
\end{tabular}
\end{table}
```

```r
cat(markdown_html(table, extensions = TRUE))
```

```
<table>
<thead>
<tr>
<th align="left">aaa</th>
<th>bbb</th>
<th align="center">ccc</th>
<th>ddd</th>
<th align="right">eee</th>
</tr>
</thead>
<tbody>
<tr>
<td align="left">fff</td>
<td>ggg</td>
<td align="center">hhh</td>
<td>iii</td>
<td align="right">jjj</td>
</tr></tbody></table>
```
