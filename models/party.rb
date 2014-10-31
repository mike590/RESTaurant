class Party < ActiveRecord::Base
	belongs_to(:server)
	has_many(:orders)
	has_many(:foods,:through => :orders)

	validates :name, :size, presence: true

	validates :name, uniqueness: true

	validates :size, numericality: {only_integer: true }

	after_initialize :init
	def init
		self.paid ||= "false"
	end
	def to_html
		sum = 0
		self.foods.each do |food|
			sum += food.price
		end
		if self.shape_selector == 0
			"<div style='height: 140px; width: 140px; background-color: #{Server.find(self.server_id).color}'>#{self.name}: Party of #{self.size}, $#{sum}</div>"
		elsif self.shape_selector == 1
			"<div style='height: 100px; width: 200px; background-color: #{Server.find(self.server_id).color}'>#{self.name}: Party of #{self.size}, $#{sum}</div>"
		else
			"<div style='height: 130px; width: 130px; border-radius: 50%; background-color: #{Server.find(self.server_id).color}'>#{self.name}: Party of #{self.size}, $#{sum}</div>"
		end
		# "<div style='width: 180px; height: 70px; background-color: pink; margin-top: 5px; margin-bottom: 5px;'><div style='margin: auto;'>#{self.name}</div><div style='margin: auto;'>Size: #{self.size}</div><div style='margin: auto;'>Total: $#{sum}</div></div>"
	end
	def to_s
		"Party Name: " + self.name
	end
end