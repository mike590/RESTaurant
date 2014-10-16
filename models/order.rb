class Order < ActiveRecord::Base
	belongs_to(:food)
	belongs_to(:party)
	after_initialize :init

	def init
		self.no_charge ||= "false"
	end
	def to_s
		"Order Number: " + self.id
	end
end