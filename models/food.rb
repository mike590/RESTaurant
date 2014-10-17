class Food < ActiveRecord::Base
	has_many(:orders)
	has_many(:parties,:through => :orders)

	validates :name, :price, presence: true

	validates :name, uniqueness: true

	validates :price, numericality: true

	def to_s
		"Food: " + self.name
	end
end