# -*- encoding: utf-8 -*-

FactoryGirl.define do

  factory :currency do

    factory :eur do
      code "eur"
      symbol "€"
    end

    factory :usd do
      code "usd"
      symbol "$"
    end
  end
end
