class CartsController < ApplicationController
  def index
  end
  def view
  	@c = Cart.find_by(user_id: session[:user_id])
  end
  def checkout
  	@c = Cart.find_by(user_id: session[:user_id])
	Product.where(cart_id: @c.id).destroy_all
	redirect_to :back
  end
end
