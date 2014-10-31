class Server < ActiveRecord::Base
has_many(:parties)
has_many(:orders)

validates :name, :password, presence: true

validates :name, uniqueness: true


end