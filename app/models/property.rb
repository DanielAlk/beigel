class Property < ActiveRecord::Base
	extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :property_type
  belongs_to :zone
  has_many :characteristics, :as => :classifiable, :dependent => :destroy

  def type
  	self.property_type.title
  end

end
