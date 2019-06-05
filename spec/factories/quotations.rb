FactoryBot.define do
  factory :quotation do
    currency_code { "MyString" }
    buy { 1 }
    sell { 1 }
  end
end
