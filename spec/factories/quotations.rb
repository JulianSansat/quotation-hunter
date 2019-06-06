FactoryBot.define do
  factory :quotation do
    currency_code { "MyString" }
    buy { Faker::Number.number(7) }
    sell { Faker::Number.number(7) }
  end
end
