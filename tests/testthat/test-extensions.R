context("test-extensions")

test_that("list extensions", {
  expect_equal(list_extensions(), c("table", "strikethrough", "autolink", "tagfilter", "tasklist"))
})

test_that("strikethrough", {
  md <- "foo ~bar~ baz"
  expect_equal(markdown_html(md, extensions = FALSE), "<p>foo ~bar~ baz</p>\n")
  expect_equal(markdown_html(md, extensions = TRUE), "<p>foo <del>bar</del> baz</p>\n")

  expect_equal(markdown_latex(md, extensions = FALSE), "foo \\textasciitilde{}bar\\textasciitilde{} baz\n")
  expect_equal(markdown_latex(md, extensions = TRUE), "foo \\sout{bar} baz\n")

  expect_equal(markdown_man(md, extensions = FALSE), ".PP\nfoo ~bar~ baz\n")
  expect_equal(markdown_man(md, extensions = TRUE), ".PP\nfoo \n.ST \"bar\"\n baz\n")

  library(xml2)
  doc1 <- xml_ns_strip(read_xml(markdown_xml(md, extensions = FALSE)))
  doc2 <- xml_ns_strip(read_xml(markdown_xml(md, extensions = TRUE)))
  expect_length(xml_find_all(doc1, "//strikethrough"), 0)
  expect_length(xml_find_all(doc2, "//strikethrough"), 1)

})

test_that("autolink", {
  md <- "Visit: https://www.test.com"
  expect_match(markdown_html(md, extensions = FALSE), "^((?!href).)*$", perl = TRUE)
  expect_match(markdown_html(md, extensions = TRUE), "href")

  expect_equal(markdown_latex(md, extensions = FALSE), "Visit: https://www.test.com\n")
  expect_equal(markdown_latex(md, extensions = TRUE), "Visit: \\url{https://www.test.com}\n")

  expect_equal(markdown_man(md, extensions = FALSE), ".PP\nVisit: https://www.test.com\n")
  expect_equal(markdown_man(md, extensions = TRUE), ".PP\nVisit: https://www.test.com (https://www.test.com)\n")

  library(xml2)
  doc1 <- xml_ns_strip(read_xml(markdown_xml(md, extensions = FALSE)))
  doc2 <- xml_ns_strip(read_xml(markdown_xml(md, extensions = TRUE)))
  expect_length(xml_find_all(doc1, "//link"), 0)
  expect_length(xml_find_all(doc2, "//link"), 1)

})

test_that("footnotes", {
  # a single footnote
  md <- "Hello[^1]\n\n[^1]: A footnote."
  expect_equal(markdown_latex(md, footnotes = FALSE), "Hello{[}\\^{}1{]}\n\n{[}\\^{}1{]}: A footnote.\n")
  expect_equal(markdown_latex(md, footnotes = TRUE), "Hello\\footnotemark[1]\n\n\\footnotetext[1]{A footnote.\n\n}\n")

  # multiple footnotes
  md <- "Hello[^1] World[^foo-2]\n\n[^1]: A footnote.\n\n[^foo-2]: Footnote ID does not have to be a number."
  expect_equal(markdown_latex(md, footnotes = FALSE), "Hello{[}\\^{}1{]} World{[}\\^{}foo-2{]}\n\n{[}\\^{}1{]}: A footnote.\n\n{[}\\^{}foo-2{]}: Footnote ID does not have to be a number.\n")
  expect_equal(markdown_latex(md, footnotes = TRUE), "Hello\\footnotemark[1] World\\footnotemark[foo-2]\n\n\\footnotetext[1]{A footnote.\n\n}\\footnotetext[foo-2]{Footnote ID does not have to be a number.\n\n}\n")
})

test_that("embedded images do not get filtered", {
  md <- '<img src="data:image/png;base64,foobar" />\n'
  expect_equal(md, markdown_html(md))
  expect_equal(md, markdown_commonmark(md))
})
