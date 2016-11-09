class SessionsController < ApplicationController
  def index
  	if session[:user_id]
  		redirect_to '/categories'
  	end
  end
  def new
  end
  def login
  	@user = User.find_by(email: params['email'])
	  	if @user && @user.authenticate(params[:password])
	  		session[:user_id] = @user.id
  			redirect_to '/categories'
	  	else
	  		flash[:errors] = ['Invalid email / password combination']
	  		redirect_to :back
	  	end
  end
end
