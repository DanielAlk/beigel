class AvailableCharacteristic < ActiveRecord::Base
	validates :title, :group, presence: true
	enum group: [ :services, :extended, :environments, :general ]

end
