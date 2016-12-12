class Product < ActiveRecord::Base
  belongs_to :cart
  has_many :prices
end
