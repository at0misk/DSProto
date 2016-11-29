class CreateProds < ActiveRecord::Migration
  def change
    create_table :prods do |t|
      t.string :name
      t.string :manufacturer_number
      t.string :manufacturer

      t.timestamps null: false
    end
  end
end
