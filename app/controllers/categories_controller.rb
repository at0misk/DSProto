class CategoriesController < ApplicationController
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
	end
  def view
  	puts params['name']
   	@returnHash = {}
	@response = RestClient.post 'http://dentalsquid.proscrapers.com/api/get-listings', {token: '90c3562d7d962f37bee2185c2b871fd4d1cfa7f2129617033f14d9c1b2b96730', category: params['name'], page: '1'}
	@json = JSON.parse @response
	# # # if @json.is_a?(Hash)
	# # # 	puts 'hash'
	# # # end
	puts @json
	puts 'BREAK =============================================================='
	@json = JSON.parse @json['data']
	puts @json['products']
	@json['products'].each do |val|
		puts val['name']
		# if val.is_a?(Hash)
		# 	val.each do |key, val|
		# 		# @returnHash[key] = val
		# 		puts "#{key}: #{val}"
		# 	end
		# end
	end
	@j = @json
  end
end
