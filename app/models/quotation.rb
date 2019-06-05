class Quotation < ApplicationRecord

validates_presence_of :currency_code, :buy
end
