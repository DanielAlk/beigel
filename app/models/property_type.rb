class PropertyType < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged
	has_many :properties, :dependent => :destroy
	has_many :characteristics, :as => :classifiable, :dependent => :destroy
end
