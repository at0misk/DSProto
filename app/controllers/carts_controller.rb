class CartsController < ApplicationController
  def index
  end
  def view
    session[:front_door] = true
  	@c = Cart.find_by(user_id: session[:user_id])
    # begin price scrape
    j = 0
    k = 0
    @c.products.each do |p|
    @found = false
    @viewPrices = {}
    @priceParams = {}
    @queryString = params['id'].to_s
    @response = RestClient.post 'http://dentalsquid.proscrapers.com/api/get-product-mapping', {token: "90c3562d7d962f37bee2185c2b871fd4d1cfa7f2129617033f14d9c1b2b96730", q: {"0" => {"p" => p.distributor_number}}}
    @json = JSON.parse @response
    puts @json['data']
    @json['data'].each do |val|
      # puts val[params['id']]
      val[p.distributor_number].each do |val|
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
        @price = Price.new
        @price.product_id = p.id
          session[:man] = val['manufacturer']
          session[:num] = val['manufacturer_number']
          puts "HERE IS K!!!"
          finalParams['product_id'] = "#{val['product_id']}"
          finalParams['site_id'] = "#{val['site_id']}"
          if p.prices.exists?(:distributor => val['site_id'])
              @found = true
              puts 'found'
            end
          @price.distributor = val['site_id']
          if "#{val['site_id']}" == '3'
            puts "darby"
            formatString = val['price']
            formatString = formatString[5...-3]
            puts formatString
            finalParams['price'] = formatString
            @price.price = formatString
          elsif "#{val['site_id']}" == '4'
            puts "schein"
            formatString = val['price']
            formatString = formatString[5...-3]
            puts formatString
            finalParams['price'] = formatString
            @price.price = formatString
          else
            finalParams['price'] = "#{val['price']}"
            @price.price = "#{val['price']}"
          end
          @viewPrices["#{k}"] = finalParams
          puts @viewPrices["#{k}"]
          puts val['product_id']
          puts val['price']
          puts val['site_id']
          finalParams = {}
          k += 1
          if @found == false
          @price.save
          end
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
    #   puts 'hash'
    # end
    @jsonCats = JSON.parse @jsonCats['data']
    @jcats = @jsonCats
    @viewPrices
    end
    # end price scrape
  end
  def update
    @p = Product.find(params['id'])
    @p.update(quantity: params['quantity'])
    redirect_to :back
  end
  def delete
    @p = Product.find(params['id'])
    @p.destroy
    redirect_to :back
  end
  def checkout
  	@c = Cart.find_by(user_id: session[:user_id])
	Product.where(cart_id: @c.id).destroy_all
	redirect_to :back
  end
  def whole
    @c = Cart.find_by(user_id: session[:user_id])
    @c.products.each do |p|
      p.prices.each do |r|
        if r.distributor == params['id']
          p.update(price: r.price, distributor: params['distributor'])
        end
      end
    end
    redirect_to :back
  end
def cheap
  @c = Cart.find_by(user_id: session[:user_id])
  @c.products.each do |p|
    min = p.prices.first.price
    dist = 'Patterson Dental'
    p.prices.each do |s|
      if s.price.to_f < min.to_f 
        min = s.price
        if s.distributor == '1'
          dist = 'Patterson Dental'
        elsif s.distributor == '2'
          dist = 'Safco Dental'
        elsif s.distributor == '3'
          dist = 'Darby Dental'
        elsif s.distributor == '4'
          dist = 'Henry Schein'
        elsif s.distributor == '5'
          dist = 'Benco Dental'
        end
      end
    end
  p.update(price: min, distributor: dist)
end
redirect_to :back
end
end