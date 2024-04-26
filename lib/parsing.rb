require "nokogiri"

file = "lib/strawberry.html"
doc = Nokogiri::HTML.parse(File.open(file), nil, "utf-8")

doc.search('.card__title-text').first(5).each do |element|
  # recipe_hash[element.text.strip.split[0..4].join(" ")] = false
  puts element.text.strip
end
