class SessionsController < ApplicationController
  def index
  	@returnHash = {}
	@response = RestClient.post 'http://dentalsquid.proscrapers.com/api/get-categories', {token: '90c3562d7d962f37bee2185c2b871fd4d1cfa7f2129617033f14d9c1b2b96730'}
	@json = JSON.parse @response
	# puts @json
	# if @json.is_a?(Hash)
	# 	puts 'hash'
	# end
	@json = JSON.parse @json['data']
	@json['categories'].each do |val|
		puts val['name']
		if val.is_a?(Hash)
			val.each do |key, val|
				# @returnHash[key] = val
				puts "#{key}: #{val}"
			end
		end
	end
  	if session[:user_id]
  		redirect_to '/categories'
  	end
  	@jcats = @json
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
  def about
  end
end
