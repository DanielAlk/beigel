class Contact < ActiveRecord::Base
  belongs_to :contactable, polymorphic: true
  validates_presence_of :name
  validates_presence_of :email
  validates_length_of :message, minimum: 15, message: "debe contener al menos 15 caracteres"
  before_save :define_subject
  enum subject: [ :contact, :services, :investments, :assessments, :development, :property ]
  
  def subject_es
    if self.subject.present?
      [ :contacto, :servicios, :inversiones, :tasaciones, :eprendimiento, :inmueble ][Contact.subjects[self.subject]].to_s.capitalize
    end
  end

  private
  	def define_subject
  		if self.subject.blank?
  			if self.contactable.present?
  				self.subject = self.contactable_type.downcase.to_sym
  			else
  				self.subject = :contact
  			end
  		end
  	end
end
