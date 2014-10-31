require 'bundler'
Bundler.require

require 'sinatra/activerecord/rake'
require './connection'


namespace :db do
	desc "Create restaurant_db database"
	task :create_db do
		conn = PG::Connection.open()
		conn.exec('CREATE DATABASE restaurant_db;')
		conn.close
	end

	desc "Drop restaurant_db database"
	task :drop_db do
		conn = PG::Connection.open()
		conn.exec('DROP DATABASE restaurant_db;')
		conn.close
	end

	desc "Create Junk Data"
	task :create_junk_data do

		require_relative 'models/food'
    require_relative 'models/party'
    require_relative 'models/order'

    Food.create(name: 'apple', price: 5)        
    Food.create(name: 'banana', price: 6)
    Food.create(name: 'peach', price: 7)

    Party.create(name: "Mike", size: 3, paid: "false")
    Party.create(name: "Thareef", size: 5, paid: "true")

	end

end
