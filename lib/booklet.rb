require "pry"
require "hexapdf"

target = HexaPDF::Document.new
src = HexaPDF::Document.open(ARGV[0])

pages = src.pages
count = (0...src.pages.count).to_a

box = src.pages.first.box
width, height = box.width, box.height

_, _, _, long = HexaPDF::Type::Page::PAPER_SIZE[:Letter]

scale = (long / 2) / (width * 1.0)

if count.size % 4 != 0
  puts "Pages not divisible by 4!"
  exit
end

new_order = []

new_order << count.delete_at(-1)

[0,0,-1,-1].cycle do |i|
  break if count.count == 0
  new_order << count.delete_at(i)
end

new_order.each_slice(2) do |pair|
  canvas = target.pages.add(
    :Letter,
    orientation: :landscape,
  ).canvas
  page_1 = target.import(pages[pair[0]].to_form_xobject)
  page_2 = target.import(pages[pair[1]].to_form_xobject)
  width = (page_1.box.width * scale).floor
  height = (page_1.box.height * scale).floor
  canvas.xobject(page_1, at: [0,0], width: width, height: height)
  canvas.xobject(page_2, at: [width,0], width: width, height: height)
end

target.write(ARGV[1], optimize: true)
