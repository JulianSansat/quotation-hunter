FactoryBot.define do
  factory :currency do
    name { Faker::Currency.name }
    code { Faker::Currency.code }
    symbol { Faker::Currency.symbol }
    logo_url { "teste" }
  end
end
