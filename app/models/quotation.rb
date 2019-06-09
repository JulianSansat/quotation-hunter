class Quotation < ApplicationRecord
	validates_presence_of :currency_code, :buy
	def created_at
    	attributes['created_at'].strftime("%m/%d/%Y %H:%M")
  	end
end
