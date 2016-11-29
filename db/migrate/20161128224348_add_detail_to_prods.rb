class AddDetailToProds < ActiveRecord::Migration
  def change
  	add_column(:prods, :product_detail, :string)
  end
end
