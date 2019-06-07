require 'rest-client'
class QuotationsFetchService
    def self.fetch_quotations
        fetch_quotations_api
    end

    private

    def self.fetch_quotations_api
        currency_codes = ['USD', 'EUR', 'BTC']
        response = RestClient.get "https://api.hgbrasil.com/finance?key=#{Rails.application.credentials.hg_api_key}"

        json_body = JSON.parse(response.body, symbolize_names: true)
        currencies = json_body[:results][:currencies]
        currency_codes.each do |code|
            quotation = Quotation.new
            quotation.currency_code = code
            quotation.buy = format_to_6_digits(currencies[code.to_sym][:buy])
            quotation.sell = currencies[code.to_sym][:sell] != nil ? format_to_6_digits(currencies[code.to_sym][:sell]) : nil
            quotation.save  
        end
    end

    def self.format_to_6_digits(value)
        parts = value.to_s.split('.')
        integer = parts[0]
        decimal = parts[1].ljust(6, '0')

        formatted = (integer+decimal).to_i
    end

end