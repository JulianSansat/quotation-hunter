class QuotationsByDateService

    def self.quotations_variation(moment, code)
        get_quotations_variation(moment, code)
    end

    private

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