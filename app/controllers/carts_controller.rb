class CartsController < ApplicationController
  def index
  end

  def view
  	@c = Cart.find_by(user_id: session[:user_id])
  end
end
