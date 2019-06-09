class QuotationsByDateService

    def self.quotations_of(moment, code)
        get_quotations_of(moment, code)
    end

    def self.quotations_variation(moment, code)
        get_quotations_variation(moment, code)
    end

    def self.quotations_preview
        get_quotations_preview
    end

    private

    def self.get_quotations_preview
        currency_codes = ['USD', 'EUR', 'BTC']
        db_currencies = Currency.all
        if (db_currencies.length > 0)
            currency_codes = []
            db_currencies.each do |db_currency|
                currency_codes << db_currency.code
            end
        end

        quotations = Quotation.where("DATE(created_at) = ?", Date.current.yesterday).order(:created_at).group_by{|t| t.currency_code }

        result_hash = {}
        currency_codes.each do |code|
            openingPrice = quotations[code].first.buy
            closingPrice = quotations[code].last.buy
            variation = calculate_variation_percentual(openingPrice, closingPrice)
            symbol = openingPrice > closingPrice ? "-" : "+"
            result_hash[code.to_sym] = {quotations: quotations[code].last}
            result_hash[code.to_sym][:variation] = variation
            result_hash[code.to_sym][:symbol] = symbol
        end

        return result_hash
        
    end

    def self.get_quotations_of_by_code(moment, code)
        if(moment == 'yesterday')
            quotations = Quotation.
                            where("DATE(created_at) = ? AND currency_code = ?", Date.current.yesterday, code)
        elsif(moment == 'last_week')
            quotations = Quotation.
                            where(
                                "created_at >= ? AND created_at < ? AND currency_code = ?", 
                                Date.current.last_week.beginning_of_week.beginning_of_day, Date.current.beginning_of_week, code
                            )
        elsif(moment == 'last_month')
            quotations = Quotation.
                            where(
                                "created_at >= ? AND created_at < ? AND currency_code = ?", 
                                Date.current.last_month.beginning_of_month.beginning_of_day, Date.current.beginning_of_month, code
                            )
        else
            quotations = Quotation.all
        end
    end

    def self.get_quotations_of(moment)
        currency_codes = ['USD', 'EUR', 'BTC']
        db_currencies = Currency.all
        if (db_currencies.length > 0)
            currency_codes = []
            db_currencies.each do |db_currency|
                currency_codes << db_currency.code
            end
        end

        if(moment == 'yesterday')

            quotations = Quotation.where("DATE(created_at) = ?", Date.current.yesterday).order(:created_at).group_by{|t| t.currency_code }

        elsif(moment == 'last_week')

           quotations = Quotation.where(
                                "created_at >= ? AND created_at < ?", 
                                Date.current.last_week.beginning_of_week.beginning_of_day, Date.current.beginning_of_week
                                ).order(:created_at).group_by{|t| t.currency_code }

        elsif(moment == 'last_month')

            quotations = Quotation.where(
                                "created_at >= ? AND created_at < ?", 
                                Date.current.last_month.beginning_of_month.beginning_of_day, Date.current.beginning_of_month
                                ).order(:created_at).group_by{|t| t.currency_code }
        end

        result_hash = {}
        currency_codes.each do |code|
            openingPrice = quotations[code].first.buy
            closingPrice = quotations[code].last.buy
            variation = calculate_variation_percentual(openingPrice, closingPrice)
            symbol = openingPrice > closingPrice ? "-" : "+"
            result_hash[code.to_sym] = {quotations: quotations[code]}
            result_hash[code.to_sym][:variation] = variation
            result_hash[code.to_sym][:symbol] = symbol
        end

        return result_hash

    end

    def self.get_quotations_variation(moment, code)
        if(moment == 'yesterday')

            first = Quotation.
                            where("DATE(created_at) = ? AND currency_code = ?", Date.current.yesterday, code).order(:created_at).first

            last = Quotation.
                            where("DATE(created_at) = ? AND currency_code = ?", Date.current.yesterday, code).order(:created_at).last

            max = Quotation.
                            where("DATE(created_at) = ? AND currency_code = ?", Date.current.yesterday, code).maximum(:buy)

            min = Quotation.
                            where("DATE(created_at) = ? AND currency_code = ?", Date.current.yesterday, code).minimum(:buy)

        elsif(moment == 'last_week')

            first = Quotation.
                            where(
                                "created_at >= ? AND created_at < ? AND currency_code = ?", 
                                Date.current.last_week.beginning_of_week.beginning_of_day, Date.current.beginning_of_week, code
                            ).order(:created_at).first

            last = Quotation.
                            where(
                                "created_at >= ? AND created_at < ? AND currency_code = ?", 
                                Date.current.last_week.beginning_of_week.beginning_of_day, Date.current.beginning_of_week, code
                            ).order(:created_at).last

            max = Quotation.
                            where(
                                "created_at >= ? AND created_at < ? AND currency_code = ?", 
                                Date.current.last_week.beginning_of_week.beginning_of_day, Date.current.beginning_of_week, code
                            ).maximum(:buy)
            min = Quotation.
                            where(
                                "created_at >= ? AND created_at < ? AND currency_code = ?", 
                                Date.current.last_week.beginning_of_week.beginning_of_day, Date.current.beginning_of_week, code
                            ).minimum(:buy)
        elsif(moment == 'last_month')

            first = Quotation.
                            where(
                                "created_at >= ? AND created_at < ? AND currency_code = ?", 
                                Date.current.last_month.beginning_of_month.beginning_of_day, Date.current.beginning_of_month, code
                            ).order(:created_at).first

            last = Quotation.
                            where(
                                "created_at >= ? AND created_at < ? AND currency_code = ?", 
                                Date.current.last_month.beginning_of_month.beginning_of_day, Date.current.beginning_of_month, code
                            ).order(:created_at).last

            max = Quotation.
                            where(
                                "created_at >= ? AND created_at < ? AND currency_code = ?", 
                                Date.current.last_month.beginning_of_month.beginning_of_day, Date.current.beginning_of_month, code
                            ).maximum(:buy)
            min = Quotation.
                            where(
                                "created_at >= ? AND created_at < ? AND currency_code = ?", 
                                Date.current.last_month.beginning_of_month.beginning_of_day, Date.current.beginning_of_month, code
                            ).minimum(:buy)
        end

        if(first == nil || last == nil)
            return variation_data = {}
        end

        openingPrice = first.buy
        closingPrice = last.buy
        variation = calculate_variation_percentual(openingPrice, closingPrice)
        symbol = openingPrice > closingPrice ? "-" : "+" 
        variation_data = {
            'variation' => variation,
            'opening'   => openingPrice,
            'closing'   => closingPrice,
            'symbol'    => symbol
        }
    end

    def self.calculate_variation_percentual(openingPrice, closingPrice)
        variation = ((closingPrice - openingPrice).to_f/openingPrice) * 100
    end

end