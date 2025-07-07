#If this breaks you need to re-apply https://github.com/commonmark/cmark/pull/376

test_that("illegal unicode is replaced with tofu", {
  text <- "foo\023bar"
  xml <- markdown_xml(text)
  doc <- xml2::read_xml(xml)
  expect_equal(xml2::xml_text(doc), "foo\uFFFDbar")
})
