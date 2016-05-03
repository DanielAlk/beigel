class Property < ActiveRecord::Base
  belongs_to :property_type
  belongs_to :zone
  has_many :characteristics, :as => :classifiable, :dependent => :destroy

  enum currency: [ 'u$s', '$' ]
  enum area_unit: [ :mt2, :ha ]

  def type
  	self.property_type.title
  end

end
