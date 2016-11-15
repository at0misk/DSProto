class SessionsController < ApplicationController
  def index
  end
  def new
  end
  def login
  	@user = User.find_by(email: params['email'])
	  	if @user && @user.authenticate(params[:password])
	  		session[:user_id] = @user.id
  			redirect_to '/about'
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
end
