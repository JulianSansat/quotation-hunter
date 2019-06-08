# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Currency.create(name: 'US Dollar', code: 'USD',symbol: '$', logo_url: 'https://cdn4.iconfinder.com/data/icons/currency-symbols-4/128/3-512.png')
Currency.create(name: 'Euro', code: 'EUR',symbol: '€', logo_url: 'https://cdn4.iconfinder.com/data/icons/currency-symbols-4/128/13-512.png')
Currency.create(name: 'Bitcoin', code: 'BTC',symbol: '₿', logo_url: 'http://pngimg.com/uploads/bitcoin/bitcoin_PNG30.png')