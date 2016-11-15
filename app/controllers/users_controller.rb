require 'rest-client'
class UsersController < ApplicationController
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
	@j = @json
	# puts "BREAK"
	# @returnHash.each do |key, val|
	# 	puts "#{key}: #{val}"
	# end
	# @json.each do |val|
	# 	if val.is_a?(Array)
	# 		# puts val[1]
	# 		if val[1].is_a?(String)
	# 		newarr = val[1].split(",")
	# 			newarr.each do |i|
	# 				puts i
	# 				puts 'break'
	# 			end
	# 		end
	# 	end
	# end
  end
  def create
  	@user = User.new(user_params)
  	if @user.save
  		session[:user_id] = @user.id
  		redirect_to '/categories'
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to :back
  	end
  end
  	def user_params
  	params.require(:user).permit(:first, :last, :email, :office, :city, :state, :password, :phone) 
  	end
  	def edit
  	end
end
