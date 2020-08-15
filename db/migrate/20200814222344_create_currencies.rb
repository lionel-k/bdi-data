class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.references :exchange_rate, index: true, foreign_key: true, null: false
      t.float :seller
      t.float :buyer
      t.float :rate
      t.timestamps
    end
  end
end
