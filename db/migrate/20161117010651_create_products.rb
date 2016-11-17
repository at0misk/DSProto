class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :cart, index: true
      t.string :name
      t.string :price
      t.integer :quantity
      t.string :manufacturer
      t.string :manufacturer_number
      t.string :distributor
      t.string :distributor_number

      t.timestamps null: false
    end
    add_foreign_key :products, :carts
  end
end
