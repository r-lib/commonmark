context("test-extensions")

test_that("list extensions", {
  expect_equal(list_extensions(), c("table", "strikethrough", "autolink", "tagfilter", "tasklist"))
})

test_that("strikethrough", {
  md <- "~Hello~ ~~world~~!"
  expect_equal(markdown_html(md), "<p>~Hello~ ~~world~~!</p>\n")
  expect_equal(markdown_html(md, extensions = "strikethrough"), "<p>~Hello~ <del>world</del>!</p>\n")

  expect_equal(markdown_latex(md), "\\textasciitilde{}Hello\\textasciitilde{} \\textasciitilde{}\\textasciitilde{}world\\textasciitilde{}\\textasciitilde{}!\n")
  expect_equal(markdown_latex(md, extensions = "strikethrough"), "\\textasciitilde{}Hello\\textasciitilde{} \\sout{world}!\n")

  expect_equal(markdown_man(md), ".PP\n~Hello~ ~~world~~!\n")
  expect_equal(markdown_man(md, extensions = "strikethrough"), ".PP\n~Hello~ \n.ST \"world\"\n!\n")

  library(xml2)
  doc1 <- xml_ns_strip(read_xml(markdown_xml(md)))
  doc2 <- xml_ns_strip(read_xml(markdown_xml(md, extensions = "strikethrough")))
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

test_that('tagefilter', {
  input <- "<title><style></style></title>\n"
  expect_equal(input, markdown_html(input))
  expect_equal(markdown_html(input, extensions = "tagfilter"), gsub("<", '&lt;', input))
})

test_that("embedded images do not get filtered", {
  md <- '<img src="data:image/png;base64,foobar" />\n'
  expect_equal(md, markdown_html(md))
  expect_equal(md, markdown_commonmark(md))
})
