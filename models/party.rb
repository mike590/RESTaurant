class Party < ActiveRecord::Base
	has_many(:orders)
	has_many(:foods,:through => :orders)
	def to_s
		"Party Name: " + self.name
	end
end