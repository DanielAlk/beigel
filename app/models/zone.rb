class Zone < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	has_many :properties
end
