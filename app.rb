require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
adapter: 'postgresql',
database: 'restaurant_db'
	)

require './models/food'
require './models/order'
require './models/party'

get '/' do
	@orders = Order.all
	erb :index
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
	erb :'food/show'
end

post '/foods' do
	new_food = Food.create(params[:food])
	redirect "/foods/#{new_food.id}"
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
	erb :'party/show'
end

post '/parties' do
	new_party = Party.create(params[:party])
	redirect "/parties/#{new_party.id}"
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
	redirect "/parties"
end

post '/orders' do
	Order.create(params[:order])
	redirect '/'
end

patch '/orders/:id' do
	@order = Order.find(params[:id])
	erb :show
end

delete '/orders' do
end

get '/parties/:id/receipt' do
end

patch '/parties/:id/checkout' do
end