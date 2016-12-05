class AddCodeToProds < ActiveRecord::Migration
  def change
  	add_column(:prods, :code, :string)
  end
end
