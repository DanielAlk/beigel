class Development < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	belongs_to :development_type
	belongs_to :zone
	has_many :properties, :dependent => :destroy
	has_many :characteristics, :as => :classifiable, :dependent => :destroy
	has_many :images, -> { order(position: :asc) }, :as => :imageable, :dependent => :destroy
	has_many :videos, :as => :mediable, :dependent => :destroy
  validates_length_of :properties, minimum: 1, message: "debe contener al menos una", if: Proc.new { |development| development.active? }
	validates_length_of :images, minimum: 1, message: "debe contener al menos una", if: Proc.new { |development| development.active? }
  validate :activation
  before_save :clean_description
	before_save :re_slug
  before_save :activate_properties
  after_update :re_classify

	enum status: [ :development, :properties, :characteristics, :multimedia, :active, :inactive, :copy ]
	enum step: [ :principal, :propiedades, :caracteristicas, :media ]
	enum stage: [ :well, :construction, :done ]

	def type
  	self.development_type.name
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
  	self.development? || self.properties? || self.characteristics? || self.multimedia?
  end

  def step
    Development.steps.key(Development.statuses[self.status])
  end

	private
	  def slug_candidates
	    [
	      :title,
	      [ :title, :id ]
	    ]
	  end

	  def re_slug
	    self.slug = nil if self.title_changed?
	  end

	  def activation
      unless self.copy?
        if self.errors.any?
          self.reload
        end
      end
    end

    def clean_description
      sanitizer = Rails::Html::WhiteListSanitizer.new
      self.description = sanitizer.sanitize(self.description, tags: %w(strong em br a), attributes: %w(href))
    end

    def activate_properties
      if self.status_changed?
        self.properties.each do |property|
          property.save
        end
      end
    end

  	def re_classify
  		if self.development_type_id_changed?
        available_characteristic_ids = self.development_type.characteristics.select(:available_characteristic_id).map {|c|c.available_characteristic_id}
  			self.characteristics.each do |characteristic|
          unless available_characteristic_ids.include? characteristic.available_characteristic_id
            characteristic.destroy
          end
        end
        self.status = :characteristics
  		end
  	end
end
