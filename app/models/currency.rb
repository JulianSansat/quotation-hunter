class Currency < ApplicationRecord

	 validates_presence_of :name, :code, :symbol
end
