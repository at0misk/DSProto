class ProductsController < ApplicationController
	def view
		@man = params['man']
		@num = params['num']
		@code = params['id']
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
				puts key
				puts "key"
				puts "alkdsjfhaklsjdfhlaksdjfh"
				if val.is_a?(Hash)
				puts val['site_id']
				puts val['product_id']
				@responsePrices = RestClient.post 'http://dentalsquid.proscrapers.com/api/get-prices', {token: "90c3562d7d962f37bee2185c2b871fd4d1cfa7f2129617033f14d9c1b2b96730", q: {"#{j}" => {"sid" => val['site_id'], "u" => "abc@gmail.com", "p" => "testing", "ids" => {"0" => val['product_id']}}}}
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
  	puts session[:productName]
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
	@json['products'].each do |val|
		val['name'].tr!('/////////////', '')
		val['name'].tr!("\\\\\\\\\\\\\\", '')
	end
	@j = @json['products']
	render :json => @j
	end
	def create
		@cart = Cart.find_by(user_id: session[:user_id])
		@product = Product.new(cart_id: @cart.id, name: params['name'], price: params['price'], quantity: params['quantity'], manufacturer: params['manufacturer'], manufacturer_number: params['manufacturer_number'], distributor: params['distributor'], distributor_number: params['distributor_number'])
		if @product.save
			puts "saved"
		else
			puts "failed to save"
		end
		redirect_to :back
	end
end
