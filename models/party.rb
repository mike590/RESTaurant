class Party < ActiveRecord::Base
	has_many(:orders)
	has_many(:foods,:through => :orders)
	after_initialize :init
	def init
		self.paid ||= "false"
	end
	def to_s
		"Party Name: " + self.name
	end
end