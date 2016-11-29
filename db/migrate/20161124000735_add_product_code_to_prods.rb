class AddProductCodeToProds < ActiveRecord::Migration
  def change
  	add_column(:prods, :product_code, :string)
  end
end
