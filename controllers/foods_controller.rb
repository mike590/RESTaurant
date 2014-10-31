class FoodsController < ApplicationController

get '/' do
  @foods = Food.all
  authenticate!
  erb :'food/index'
end

get '/new' do
  erb :'food/new'
end

get '/:id' do
  @food = Food.find(params[:id])
  @parties = Party.all
  @orders = Order.all
  erb :'food/show'
end

post '/' do
  new_food = Food.create(params[:food])
  if new_food.valid?
    redirect "/foods/#{new_food.id}"
  else
    @errors = new_food.errors.full_messages
    erb :'food/new'
  end
end

get '/:id/edit' do
  @food = Food.find(params[:id])
  erb :'food/edit'
end

patch '/:id' do
  food = Food.find(params[:id])
  food.update(params[:food])
  redirect "/foods/#{food.id}"
end

delete '/:id' do
  Food.destroy(params[:id])
  redirect "/foods"
end




end