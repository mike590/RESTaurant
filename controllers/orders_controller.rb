class OrdersController < ApplicationController

post '/' do
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

post '/' do
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

patch '/:id' do
  order = Order.find(params[:id])
  party = Party.find(order.party_id)
  if order.no_charge == "true"
    order.update(no_charge: "false")
  else
    order.update(no_charge: "true")
  end
  redirect "/parties/#{party.id}"
end

end