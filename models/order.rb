class Order < ActiveRecord::Base
	belongs_to(:food)
	belongs_to(:party)
	def to_s
		"Order Number: " + self.id
	end
end