require 'bundler'
Bundler.require

conn = PG::Connection.open()

conn.exec('CREATE DATABASE restaurant_db;')
conn.close


conn = PG::Connection.open(dbname: 'restaurant_db')
conn.exec("CREATE TABLE foods (id SERIAL PRIMARY KEY, name varchar(50), price integer);")
conn.exec("CREATE TABLE parties (id SERIAL PRIMARY KEY, name varchar(50), size integer);")
conn.exec("CREATE TABLE orders (id SERIAL PRIMARY KEY, food_id integer, party_id integer);")
conn.close
