class Property < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :property_type
  belongs_to :zone
  has_many :characteristics, :as => :classifiable, :dependent => :destroy
  has_many :images, -> { order(position: :asc) }, :as => :imageable, :dependent => :destroy
  has_many :videos, :as => :mediable, :dependent => :destroy
  before_save :re_slug
  after_update :re_classify

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
    def re_slug
      self.slug = nil if self.title_changed?
    end

  	def re_classify
  		if self.property_type_id_changed?
  			self.characteristics.destroy_all
        self.status = :draft_characteristics
  		end
  	end
end
