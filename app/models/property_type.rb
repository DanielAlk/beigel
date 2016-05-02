class PropertyType < ActiveRecord::Base
	has_many :properties, :dependent => :destroy
	has_many :characteristics, :as => :classifiable, :dependent => :destroy
end
