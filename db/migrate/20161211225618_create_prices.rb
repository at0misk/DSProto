class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :distributor
      t.string :price
      t.string :quantity
      t.references :product, index: true

      t.timestamps null: false
    end
    add_foreign_key :prices, :products
  end
end
