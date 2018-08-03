require "hexapdf"

target = HexaPDF::Document.new
src = HexaPDF::Document.open(ARGV[0])
page = target.import(src.pages.first.to_form_xobject)

width = page.box.width
height = page.box.height

puts "page count: #{src.pages.count}"
page_count = (src.pages.count / 4)
page_count += 1 if page_count.odd?

tl = [0,17,2,19,4,21,6,23,8,25,10,27,12,29,14,31]
tr = [16,1,18,3,20,5,22,7,24,9,26,11,28,13,30,15]
bl = [32,49,34,51,36,53,38,55,40,57,42,59,44,61,46,63]
br = [48,33,50,35,52,37,54,39,56,41,58,43,60,45,62,47]

# mg = (width / 17)
# mult = 0.882
# (0..15).each do |i|
#   canvas = target.pages.add(
#     :Letter,
#     orientation: :portrait,
#   ).canvas
#   top_left = target.import(src.pages[tl[i]].to_form_xobject) unless src.pages[tl[i]].nil?
#   top_right = target.import(src.pages[tr[i]].to_form_xobject) unless src.pages[tr[i]].nil?
#   bottom_left = target.import(src.pages[bl[i]].to_form_xobject) unless src.pages[bl[i]].nil?
#   bottom_right = target.import(src.pages[br[i]].to_form_xobject) unless src.pages[br[i]].nil?
#   canvas.xobject(top_left, at: [mg, height + mg], width: width * 0.882, height: height * 0.882) unless top_left.nil?
#   canvas.xobject(top_right, at: [width + mg, height + mg], width: width * 0.882, height: height * 0.882) unless top_right.nil?
#   canvas.xobject(bottom_left, at: [mg, mg], width: width * 0.882, height: height * 0.882) unless bottom_left.nil?
#   canvas.xobject(bottom_right, at: [width + mg, mg], width: width * 0.882, height: height * 0.882) unless bottom_right.nil?
# end
# target.write(ARGV[1], optimize: true)
