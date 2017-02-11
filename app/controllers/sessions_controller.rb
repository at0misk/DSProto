class SessionsController < ApplicationController
  def index
  end
  def new
  end
  def login
  	@user = User.find_by(email: params['email'])
	  	if @user && @user.authenticate(params[:password])
	  		session[:user_id] = @user.id
	  		@c = Cart.find_by(user_id: @user.id)
	  			if @c.nil?
	  				Cart.create(user_id: @user.id)
	  			end
  			redirect_to '/landing'
	  	else
	  		flash[:errors] = ['Invalid email / password combination']
	  		redirect_to :back
	  	end
  end
  def about
  	if !session[:user_id]
  		redirect_to '/sessions/index'
  	end
  end
  def learn
  end
  def pricing
  end
  def contact
  end
  def cart
  end
  def destroy
    session[:user_id] = nil
    redirect_to '/sessions/index'
  end
  def landing
  end
  def friend
  end
end
