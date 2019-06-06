class QuotationsByDateService
    
    def self.quotations_of(moment, code)
        get_quotations_of(moment, code)
    end

    private

    def self.get_quotations_of(moment, code)
        if(moment == 'yesterday')
            quotations = Quotation.
                            where("DATE(created_at) = ? AND currency_code = ?", Date.current.yesterday, code)
        elsif(moment == 'last_week')
            quotations = Quotation.
                            where(
                                "created_at > ? AND created_at < ? AND currency_code = ?", 
                                Date.current.last_week.beginning_of_week.beginning_of_day, Date.current.beginning_of_week, code
                            )
        elsif(moment == 'last_month')
            quotations = Quotation.
                            where(
                                "created_at > ? AND created_at <= ? AND currency_code = ?", 
                                Date.current.last_month.beginning_of_month.beginning_of_day, Date.current.beginning_of_month, code
                            )
        else
            quotations = Quotation.all
        end
    end
end