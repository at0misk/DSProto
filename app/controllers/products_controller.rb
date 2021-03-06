class ProductsController < ApplicationController
	def view
		@user = User.find(session[:user_id])
		@creds = @user.creds
		session[:front_door] = true
		@man = params['man']
		@num = params['num']
		@code = params['id']
		@description = Prod.find_by(name: params['name'])
		@viewPrices = {}
		@priceParams = {}
	  	@queryString = params['id'].to_s
		@response = RestClient.post 'http://dentalsquid.proscrapers.com/api/get-product-mapping', {token: "90c3562d7d962f37bee2185c2b871fd4d1cfa7f2129617033f14d9c1b2b96730", q: {"0" => {"p" => params['id']}}}
		@json = JSON.parse @response
		puts @json['data']
		@json['data'].each do |val|
			puts val[params['id']]
			val[params['id']].each do |val|
			if val.is_a?(Array)
				val.each do |val|
					puts val
					puts "BREAK"
					if val.is_a?(Array)
						i = 0
						newParams = {}
						val.each do |val|
							puts "product_id: " + "#{val['product_id']}"
							newParams["product_id"] = "#{val['product_id']}"
							newParams["site_id"] = "#{val['site_id']}"
							@priceParams["#{i}"] = newParams
							puts @priceParams["#{i}"]
							newParams = {}
							i += 1
							puts "site_id: " + "#{val['site_id']}"
							puts "INNER BREAK"
						end
					end
				end
			end
				puts val
				puts "2222"
			end
		end
		puts @priceParams
		j = 0
		k = 0
		@priceParams.each do |key, val|
				if val['site_id'] == '1'
					if @creds[0]['patterson_u'] == nil
						next
					else
					user_cred = @creds[0]['patterson_u']
					user_p = @creds[0]['patterson_p']
					end
				elsif val['site_id'] == '2'
					if @creds[0]['safco_u'] == nil
						next
					else
					user_cred = @creds[0]['safco_u']
					user_p = @creds[0]['safco_p']
					end
				elsif val['site_id'] == '3'
					if @creds[0]['darby_u'] == nil
						next
					else
					user_cred = @creds[0]['darby_u']
					user_p = @creds[0]['darby_p']
					end
				elsif val['site_id'] == '4'
					if @creds[0]['henry_u'] == nil
						next
					else
					user_cred = @creds[0]['henry_u']
					user_p = @creds[0]['henry_p']
					end
				elsif val['site_id'] == '5'
					if @creds[0]['benco_u'] == nil
						next
					else
					user_cred = @creds[0]['benco_u']
					user_p = @creds[0]['benco_p']
					end
				end
				puts key
				puts "key"
				puts "alkdsjfhaklsjdfhlaksdjfh"
				if val.is_a?(Hash)
				puts val['site_id']
				puts val['product_id']
				@responsePrices = RestClient.post 'http://dentalsquid.proscrapers.com/api/get-prices', {token: "90c3562d7d962f37bee2185c2b871fd4d1cfa7f2129617033f14d9c1b2b96730", q: {"#{j}" => {"sid" => val['site_id'], "u" => user_cred, "p" => user_p, "ids" => {"0" => val['product_id']}}}}
				@jsonPrices = JSON.parse @responsePrices
				puts @jsonPrices['data']
				finalParams = {}
				@jsonPrices['data'].each do |val|
					session[:man] = val['manufacturer']
					session[:num] = val['manufacturer_number']
					puts "HERE IS K!!!"
					finalParams['product_id'] = "#{val['product_id']}"
					finalParams['site_id'] = "#{val['site_id']}"
					if "#{val['site_id']}" == '3'
						puts "darby"
						formatString = val['price']
						formatString = formatString[5...-3]
						puts formatString
						finalParams['price'] = formatString
					elsif "#{val['site_id']}" == '4'
						puts "schein"
						formatString = val['price']
						formatString = formatString[5...-3]
						puts formatString
						finalParams['price'] = formatString
					else
						finalParams['price'] = "#{val['price']}"
					end
					@viewPrices["#{k}"] = finalParams
					puts @viewPrices["#{k}"]
					puts val['product_id']
					puts val['price']
					puts val['site_id']
					finalParams = {}
					k += 1
				end
				puts "AHHHHHHHHHH"
				j += 1
				end
		end
		puts "FINAL VAR"
		puts @viewPrices
		@viewPrices.each do |key, val|
			puts key
			puts val
		end
		@viewPrices["#{k}"] = params['name']
		@responseCats = RestClient.post 'http://dentalsquid.proscrapers.com/api/get-categories', {token: '90c3562d7d962f37bee2185c2b871fd4d1cfa7f2129617033f14d9c1b2b96730'}
		@jsonCats = JSON.parse @responseCats
		# puts @json
		# if @json.is_a?(Hash)
		# 	puts 'hash'
		# end
		@jsonCats = JSON.parse @jsonCats['data']
		@jcats = @jsonCats
		@viewPrices
	end
	def index
	end
	def all
	# replace here with db data 
 #  	puts session[:productName]
 #   	@returnHash = {}
	# @response = RestClient::Request.execute(:method => :post, :url => 'http://dentalsquid.proscrapers.com/api/get-listings', :payload => {token: '90c3562d7d962f37bee2185c2b871fd4d1cfa7f2129617033f14d9c1b2b96730'}, :timeout => 90000000)
	# @json = JSON.parse @response
	# # # # if @json.is_a?(Hash)
	# # # # 	puts 'hash'
	# # # # end
	# puts @json
	# # puts 'BREAK =============================================================='
	# @json = JSON.parse @json['data']
	# # puts @json['products']
	# @json['products'].each do |val|
	# 	val['name'].tr!('/////////////', '')
	# 	val['name'].tr!("\\\\\\\\\\\\\\", '')
	# end
	@j = Prod.all
	render :json => @j
	end
	def cacheAll
   	@returnHash = {}
	@response = RestClient::Request.execute(:method => :post, :url => 'http://dentalsquid.proscrapers.com/api/get-listings', :payload => {token: '90c3562d7d962f37bee2185c2b871fd4d1cfa7f2129617033f14d9c1b2b96730'}, :timeout => 90000000)
	@json = JSON.parse @response
	# # # if @json.is_a?(Hash)
	# # # 	puts 'hash'
	# # # end
	puts @json
	# puts 'BREAK =============================================================='
	@json = JSON.parse @json['data']
	# puts @json['products']
	Prod.destroy_all
	@json['products'].each do |val|
		val['name'].tr!('/////////////', '')
		val['name'].tr!("\\\\\\\\\\\\\\", '')
		val['name'].tr!('############', '')
		@p = Prod.new
		@p.name = val['name']
		@p.manufacturer = val['manufacturer']
		@p.manufacturer_number = val['manufacturer_number']
		@p.code = val['product_code']
		@p.product_code = val['product_code']
		@p.product_detail = val['product_detail']
		@p.save
	end
	@j = @json['products']
	redirect_to :back
	end
	def create
		@cart = Cart.find_by(user_id: session[:user_id])
		@p = Product.where(cart_id: @cart.id, name: params['name'], distributor: params['distributor'])
		if @p.empty?
			@product = Product.new(cart_id: @cart.id, name: params['name'], price: params['price'], quantity: params['quantity'], manufacturer: params['manufacturer'], manufacturer_number: params['manufacturer_number'], distributor: params['distributor'], distributor_number: params['distributor_number'])
			if @product.save
				puts "saved"
			else
				puts "failed to save"
			end
		else
			@newQuantity = @p[0].quantity += params['quantity'].to_i
			@p[0].update(quantity: @newQuantity)
		end
		redirect_to :back
	end
	def search
	end
	def searchQ
		session[:front_door] = true
		session[:searchP] = params['sparams']
		@results = Prod.where("name LIKE ? OR manufacturer LIKE ? OR manufacturer_number LIKE ? OR product_detail LIKE ? OR code LIKE ?", "%#{params['sparams']}%","%#{params['sparams']}%","%#{params['sparams']}%","%#{params['sparams']}%","%#{params['sparams']}%")
	end
	def searchQAng
		session[:front_door] = true
		@results = Prod.where("name LIKE ? OR manufacturer LIKE ? OR manufacturer_number LIKE ? OR product_detail LIKE ? OR code LIKE ?", "%#{session[:searchP]}%","%#{session[:searchP]}%","%#{session[:searchP]}%","%#{session[:searchP]}%","%#{session[:searchP]}%")
		render :json => @results
	end
	def dist
	    @p = Product.find(params['id'])
	    @p.update(quantity: params['quantity'], price: params['price'], distributor: params['distributor'])
	    redirect_to :back
	end
	def history
		@returnArrSafco = []
		@user = User.find(session[:user_id])
		@creds = @user.creds
		session[:front_door] = true
		j = 1
		k = 1
		user_cred = ""
		user_p = ""
		for n in 1..5
			if n == 1
				user_cred = @creds[0]['patterson_u']
				user_p = @creds[0]['patterson_p']
			elsif n == 2
				user_cred = @creds[0]['safco_u']
				user_p = @creds[0]['safco_p']
			elsif n == 3
				user_cred = @creds[0]['darby_u']
				user_p = @creds[0]['darby_p']
			elsif n == 4
				user_cred = @creds[0]['henry_u']
				user_p = @creds[0]['henry_p']
			elsif n == 5
				user_cred = @creds[0]['benco_u']
				user_p = @creds[0]['benco_p']
			end
			puts user_cred
			puts user_p
			@response = RestClient.post 'http://dentalsquid.proscrapers.com/api/get-order-history', {token: "90c3562d7d962f37bee2185c2b871fd4d1cfa7f2129617033f14d9c1b2b96730", q: {"#{j}" => {"sid" => "#{n}", "u" => "#{user_cred}", "p" => "#{user_p}"}}}
			# @json = JSON.parse @response
			# @json = JSON.parse @json['data']
			@json = JSON.parse @response
			# @jsonData = @json['data']['products']
			puts "=======^^^======"
			if n == 2
			@json['data'].each do |val|
				val['products'].each do |x|
					@inner = {}
					puts x['name']
					@inner['name'] = x['name']
					@inner['price'] = x['price']
					@returnArrSafco << @inner
				end
			end
			# fail
				# @returnArr = @json['data'][1]
			end
			# puts @data['products']
			j += 1
			puts j
			puts n
			puts "J ^^^^"
		end
	end
end
