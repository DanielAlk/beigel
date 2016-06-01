class Property < ActiveRecord::Base
  extend FriendlyId
  include Filterable
  friendly_id :slug_candidates, use: :slugged
  belongs_to :development
  belongs_to :property_type
  belongs_to :zone
  has_one :showcase_item, :as => :showcaseable, :dependent => :destroy
  has_one :promotion, :as => :promotionable, :dependent => :destroy
  has_many :contacts, :as => :contactable, :dependent => :destroy
  has_many :characteristics, :as => :classifiable, :dependent => :destroy
  has_many :images, -> { order(position: :asc) }, :as => :imageable, :dependent => :destroy
  has_many :videos, :as => :mediable, :dependent => :destroy
  validates_length_of :images, minimum: 1, message: "debe contener al menos una", if: Proc.new { |property| property.active? }
  validate :activation
  before_save :re_slug
  before_save :calculate_area
  before_save :clean_description
  before_save :development_property
  after_update :re_classify

  scope :operation_type, -> (operation_type) { operation_type == :buy ? where.not(sale_price: nil) : where.not(rent_price: nil) }
  scope :price, -> (operation_type, price_min, price_max) { operation_type == :buy ? where(sale_price: price_min..price_max) : where(rent_price: price_min..price_max) }
  scope :currency, -> (operation_type, currency) { operation_type == :buy ? where(sale_currency: currency) : where(rent_currency: currency) }
  scope :property_type, -> (property_type_id) { where(property_type_id: property_type_id) }
  scope :property_type_slug, -> (property_type_slugs) { where(property_type_id: PropertyType.where(slug: property_type_slugs).map {|pt|pt.id}) }
  scope :environments, -> (environments) { where(environments: environments) }
  scope :zone, -> (zone_ids) { where(zone_id: zone_ids) }
  scope :zone_slug, -> (zone_slugs) { where(zone_id: Zone.where(slug: zone_slugs).map {|z|z.id}) }
  scope :area, -> (area) { where(area: area) }
  scope :title, -> (title) { where('title LIKE ?', ['%' + title + '%']) }
  scope :status_filter, -> (status) { where(status: status) }
  scope :order_filter, -> (filter) do
    filter = filter.respond_to?(:each) ? filter[0] : filter
    way = filter.to_s.slice(/_asc|_desc/).remove('_')
    property = filter.to_s.remove(/_asc|_desc/)
    if property == 'price'
      argument = [ { sale_price: way }, { rent_price: way } ]
    else
      argument = {}
      argument[property] = way
    end
    order(argument)
  end

  enum status: [ :property, :characteristics, :multimedia, :active, :inactive, :copy ]
  enum step: [ :principal, :caracteristicas, :media ]
  enum currency: [ 'u$s', '$' ]
  enum area_unit: [ :mt2, :ha ]

  def type
  	self.property_type.title
  end

  def short
    if self.info.present?
      self.info
    else
      sanitizer = Rails::Html::WhiteListSanitizer.new
      short_description = sanitizer.sanitize(self.description, tags: [])[0..140].split(' ')
      short_description.pop()
      (short_description.join(' ') + '...')
    end
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

    def development_property
      if self.development.present?
        self.zone = self.development.zone
        self.address = self.development.address
        self.zip_code = self.development.zip_code
        self.lat = self.development.lat
        self.lng = self.development.lng
        self.age = 0
        self.images.new(item: self.development.images.first.item) if self.images.blank? && self.development.images.present?
        self.status = self.development.draft? ? :property : self.development.status
      end
    end

    def calculate_area
      self.area = self.constructed_area + self.unconstructed_area
    end

    def clean_description
      sanitizer = Rails::Html::WhiteListSanitizer.new
      self.description = sanitizer.sanitize(self.description, tags: %w(strong em br a), attributes: %w(href))
    end

    def activation
      unless self.copy?
        if self.errors.any?
          self.reload
        end
      end
    end

    def re_slug
      self.slug = nil if self.title_changed?
    end

  	def re_classify
  		if self.property_type_id_changed?
        available_characteristic_ids = self.property_type.characteristics.select(:available_characteristic_id).map {|c|c.available_characteristic_id}
  			self.characteristics.each do |characteristic|
          unless available_characteristic_ids.include? characteristic.available_characteristic_id
            characteristic.destroy
          end
        end
        self.status = :characteristics
  		end
  	end
end
