class PartiesController < ApplicationController

get '/' do
  @parties = Party.all
  erb :'party/index'
end

get '/new' do
  authenticate!
  erb :'party/new'
end

get '/:id' do
  @party = Party.find(params[:id])
  @foods = Food.all
  @orders = Order.all
  erb :'party/show'
end

post '/' do
  new_party = Party.create(params[:party])
  if new_party.valid?
    redirect "/parties/#{new_party.id}"
  else
    @errors = new_party.errors.full_messages
    erb :'party/new'
  end
end

get '/:id/edit' do
  @party = Party.find(params[:id])
  erb :'party/edit'
end

patch '/:id' do
  party = Party.find(params[:id])
  party.update(params[:party])
  redirect "/parties/#{party.id}"
end

delete '/:id' do
  Party.destroy(params[:id])
  orders = Order.all
  orders.each do |order|
    if order.party_id.to_i == params[:id].to_i
      Order.destroy(order.id)
    end
  end
  redirect "/parties"
end

get '/:id/receipt' do
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

patch '/:id/checkout' do
  party = Party.find(params[:id])
  party.update(paid: "true")
  redirect "/parties/#{party.id}"
end



end