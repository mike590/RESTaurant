require 'bundler'
Bundler.require
require './connection'


require './models/food'
require './models/order'
require './models/party'

get '/' do
	redirect '/parties'
end

get '/foods' do
	@foods = Food.all
	erb :'food/index'
end

get '/foods/new' do
	erb :'food/new'
end

get '/foods/:id' do
	@food = Food.find(params[:id])
	@parties = Party.all
	@orders = Order.all
	erb :'food/show'
end

post '/foods' do
	new_food = Food.create(params[:food])
	if new_food.valid?
		redirect "/foods/#{new_food.id}"
	else
		@errors = new_food.errors.full_messages
		erb :'food/new'
	end
end

get '/foods/:id/edit' do
	@food = Food.find(params[:id])
	erb :'food/edit'
end

patch '/foods/:id' do
	food = Food.find(params[:id])
	food.update(params[:food])
	redirect "/foods/#{food.id}"
end

delete '/foods/:id' do
	Food.destroy(params[:id])
	redirect "/foods"
end

get '/parties' do
	@parties = Party.all
	erb :'party/index'
end

get '/parties/new' do
	erb :'party/new'
end

get '/parties/:id' do
	@party = Party.find(params[:id])
	@foods = Food.all
	@orders = Order.all
	erb :'party/show'
end

post '/parties' do
	new_party = Party.create(params[:party])
	if new_party.valid?
		redirect "/parties/#{new_party.id}"
	else
		@errors = new_party.errors.full_messages
		erb :'party/new'
	end
end

get '/parties/:id/edit' do
	@party = Party.find(params[:id])
	erb :'party/edit'
end

patch '/parties/:id' do
	party = Party.find(params[:id])
	party.update(params[:party])
	redirect "/parties/#{party.id}"
end

delete '/parties/:id' do
	Party.destroy(params[:id])
	orders = Order.all
	orders.each do |order|
		if order.party_id.to_i == params[:id].to_i
			Order.destroy(order.id)
		end
	end
	redirect "/parties"
end

post '/orders' do
	@party = Party.find_by(name: params[:party_name])# find the right party
	food = Food.find_by(name: params[:food_name])# find the right food
	if food
		order = Order.create(party_id:  @party.id, food_id: food.id) # create the order based on both
		redirect "/parties/#{@party.id}"
	else
		order = Order.create(party_id:  @party.id) # create the order based on both
		@errors = order.errors.full_messages
		erb :'party/show'
	end
end


get '/parties/:id/receipt' do
	party = Party.find(params[:id])
	# to get the parties foods we call party.foods
	sum = 0
	receipt = File.open('active_receipt.txt', "w") do |receipt|
		receipt.write("Thank you for dining with us!\n")
		receipt.write("#{party.name}\nSize: #{party.size}\n")
	  party.foods.each do |food|
	  	receipt.write("#{food.name}: $#{food.price}\n")
	  	temp_order = Order.where(food_id: food.id, party_id: party.id).first
	  	if temp_order.no_charge == "true"
	  		receipt.write("--- No-charge ---\n")
	  	else
	  	sum += food.price
	  end
	  end
	  receipt.write("Total: $#{sum}\n")
	  receipt.write("15% Gratuity: $ #{'%.2f' % (sum * 1.15)}\n")
		receipt.write("20% Gratuity: $ #{'%.2f' % (sum * 1.2)}\n")
		receipt.write("25% Gratuity: $ #{'%.2f' % (sum * 1.25)}\n")

	end
	attachment('receipt.txt')
	File.read("active_receipt.txt")
end

patch '/orders/:id' do
	order = Order.find(params[:id])
	party = Party.find(order.party_id)
	if order.no_charge == "true"
		order.update(no_charge: "false")
	else
		order.update(no_charge: "true")
	end
	redirect "/parties/#{party.id}"
end

delete '/orders/:id' do
	Order.destroy(params[:id])
	party = Party.find(params[:party_id])
	redirect "/parties/#{party.id}"
end


patch '/parties/:id/checkout' do
	party = Party.find(params[:id])
	party.update(paid: "true")
	redirect "/parties/#{party.id}"
end

get '/console' do
	binding.pry
	redirect '/'
end