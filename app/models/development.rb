class Development < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	belongs_to :development_type
	belongs_to :zone
	has_many :characteristics, :as => :classifiable, :dependent => :destroy
	has_many :images, -> { order(position: :asc) }, :as => :imageable, :dependent => :destroy
	has_many :videos, :as => :mediable, :dependent => :destroy
	validates_length_of :images, minimum: 1, message: "debe contener al menos una", if: Proc.new { |development| development.active? }
	before_save :re_slug

	enum status: [ :development, :properties, :characteristics, :multimedia, :active, :inactive, :copy ]
	enum step: [ :principal, :propiedades, :caracteristicas, :media ]

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
end
