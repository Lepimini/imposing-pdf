require "hexapdf"

target = HexaPDF::Document.new
src = HexaPDF::Document.open(ARGV[0])
src_page = src.pages.first
page = target.import(src_page.to_form_xobject)

original_width = page.box.width
height = page.box.height

canvas = target.pages.add(HexaPDF::Type::Page::PAPER_SIZE[:Letter]).canvas

canvas.xobject(page, at: [0, 0], width: width, height: height)
canvas.xobject(page, at: [width, 0], width: width, height: height)
canvas.xobject(page, at: [0, height], width: width, height: height)
canvas.xobject(page, at: [width, height], width: width, height: height)

target.write(ARGV[1], optimize: true)
