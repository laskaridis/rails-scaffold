# -*- encoding: utf-8 -*-

puts "-- Loading currencies"

Currency.where(code: "EUR").first_or_create!(symbol: "€")
Currency.where(code: "USD").first_or_create!(symbol: "$")
Currency.where(code: "RUB").first_or_create!(symbol: "руб")
Currency.where(code: "JPY").first_or_create!(symbol: "¥")
Currency.where(code: "GBP").first_or_create!(symbol: "£")

puts "-- Finished loading currencies"
