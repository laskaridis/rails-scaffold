
puts "-- Loading languages"

Language.where(code: "en").first_or_create!
Language.where(code: "el").first_or_create!

puts "-- Finished loading languages"
