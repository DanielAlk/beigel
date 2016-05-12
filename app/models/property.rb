class Property < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  belongs_to :property_type
  belongs_to :zone
  has_many :characteristics, :as => :classifiable, :dependent => :destroy
  has_many :images, -> { order(position: :asc) }, :as => :imageable, :dependent => :destroy
  has_many :videos, :as => :mediable, :dependent => :destroy
  validates_length_of :images, minimum: 1, message: "debe contener al menos una", if: Proc.new { |property| property.active? }
  validate :activation
  before_save :re_slug
  after_update :re_classify

  enum status: [ :property, :characteristics, :multimedia, :active, :inactive, :copy ]
  enum step: [ :principal, :caracteristicas, :media ]
  enum currency: [ 'u$s', '$' ]
  enum area_unit: [ :mt2, :ha ]

  def type
  	self.property_type.title
  end

  def draft?
  	self.property? || self.characteristics? || self.multimedia?
  end

  def for_sale?
    self.sale_price.present?
  end

  def for_rent?
    self.rent_price.present?
  end

  def for_sale_and_rent?
    self.for_sale? && self.for_rent?
  end

  def currency_for(operation_type)
    if operation_type == :sale
      Property.currencies.keys[self.sale_currency]
    elsif operation_type == :rent
      Property.currencies.keys[self.rent_currency]
    end
  end

  def area
    self.constructed_area + self.unconstructed_area
  end

  def step
    Property.steps.key(Property.statuses[self.status])
  end

  private
    def slug_candidates
      [
        :title,
        [ :title, :id ]
      ]
    end

    def activation
      if self.errors.any?
        self.reload
      end
    end

    def re_slug
      self.slug = nil if self.title_changed?
    end

  	def re_classify
  		if self.property_type_id_changed?
  			self.characteristics.destroy_all
        self.status = :characteristics
  		end
  	end
end
