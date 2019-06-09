# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#Currency.create(name: 'US Dollar', code: 'USD',symbol: '$', logo_url: 'https://cdn4.iconfinder.com/data/icons/currency-symbols-4/128/3-512.png')
#Currency.create(name: 'Euro', code: 'EUR',symbol: '€', logo_url: 'https://cdn4.iconfinder.com/data/icons/currency-symbols-4/128/13-512.png')
#Currency.create(name: 'Bitcoin', code: 'BTC',symbol: '₿', logo_url: 'http://pngimg.com/uploads/bitcoin/bitcoin_PNG30.png')

#yesterday
Quotation.create(currency_code: 'USD', buy: 3450000, created_at: Date.current.yesterday.beginning_of_day)
Quotation.create(currency_code: 'USD', buy: 3850000, created_at: Date.current.yesterday.end_of_day)

Quotation.create(currency_code: 'EUR', buy: 4450000, created_at: Date.current.yesterday.beginning_of_day)
Quotation.create(currency_code: 'EUR', buy: 4850000, created_at: Date.current.yesterday.end_of_day)

Quotation.create(currency_code: 'BTC', buy: 2345000000, created_at: Date.current.yesterday.beginning_of_day)
Quotation.create(currency_code: 'BTC', buy: 2385000000, created_at: Date.current.yesterday.end_of_day)

#last week
Quotation.create(currency_code: 'USD', buy: 3150000, created_at: Date.current.last_week.beginning_of_week.beginning_of_day)
Quotation.create(currency_code: 'USD', buy: 3650000, created_at: Date.current.last_week.beginning_of_week.end_of_day)

Quotation.create(currency_code: 'EUR', buy: 4450000, created_at: Date.current.last_week.beginning_of_week.beginning_of_day)
Quotation.create(currency_code: 'EUR', buy: 3850000, created_at: Date.current.last_week.beginning_of_week.end_of_day)

Quotation.create(currency_code: 'BTC', buy: 2045000000, created_at: Date.current.last_week.beginning_of_week.beginning_of_day)
Quotation.create(currency_code: 'BTC', buy: 2485000000, created_at: Date.current.last_week.beginning_of_week.end_of_day)

#last month

Quotation.create(currency_code: 'USD', buy: 5150000, created_at: Date.current.last_month.beginning_of_month.beginning_of_day)
Quotation.create(currency_code: 'USD', buy: 4650000, created_at: Date.current.last_month.beginning_of_month.end_of_day)

Quotation.create(currency_code: 'EUR', buy: 3450000, created_at: Date.current.last_month.beginning_of_month.beginning_of_day)
Quotation.create(currency_code: 'EUR', buy: 3250000, created_at: Date.current.last_month.beginning_of_month.end_of_day)

Quotation.create(currency_code: 'BTC', buy: 1945000000, created_at: Date.current.last_month.beginning_of_month.beginning_of_day)
Quotation.create(currency_code: 'BTC', buy: 1885000000, created_at: Date.current.last_month.beginning_of_month.end_of_day)
