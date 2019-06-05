class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :code
      t.string :symbol
      t.string :logo_url, :null => true

      t.timestamps
    end
  end
end
