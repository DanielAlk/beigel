class DevelopmentType < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged
	has_many :developments, :dependent => :destroy
	has_many :characteristics, :as => :classifiable, :dependent => :destroy
end
