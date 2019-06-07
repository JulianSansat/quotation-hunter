class CreateQuotations < ActiveRecord::Migration[5.2]
  def change
    create_table :quotations do |t|
      t.string :currency_code
      t.integer :buy, limit: 8
      t.integer :sell, limit: 8, :null => true

      t.timestamps
    end
  end
end
