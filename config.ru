require 'bundler'
Bundler.require

Dir.glob('./{helpers,models,controllers}/*.rb').each do |file|
  require file
  puts "required #{file}"
end

map('/sessions'){ run SessionsController}
map('/foods'){ run FoodsController}
map('/parties'){ run PartiesController}
map('/orders'){ run OrdersController}
map('/'){ run ApplicationController}