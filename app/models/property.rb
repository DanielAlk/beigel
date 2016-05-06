class Property < ActiveRecord::Base
  belongs_to :property_type
  belongs_to :zone
  has_many :characteristics, :as => :classifiable, :dependent => :destroy
  after_update :update_characteristics

  enum status: [ :draft_property, :draft_characteristics, :draft_multimedia, :active, :inactive, :copy ]
  enum step: [ :main, :characteristics, :multimedia ]
  enum currency: [ 'u$s', '$' ]
  enum area_unit: [ :mt2, :ha ]

  def type
  	self.property_type.title
  end

  def draft?
  	self.draft_property? || self.draft_characteristics? || self.draft_multimedia?
  end

  private
  	def update_characteristics
  		if self.property_type_id_changed?
  			self.characteristics.destroy_all
        self.status = :draft_characteristics
  		end
  	end
end
