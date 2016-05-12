class Characteristic < ActiveRecord::Base
  belongs_to :classifiable, polymorphic: true
  belongs_to :available_characteristic
  enum group: [ :services, :extended, :environments, :general ]
  before_save :get_group

  def title
  	self.available_characteristic.title
  end

  def group
  	self.available_characteristic.group
  end

  def options
    self.available_characteristic.options
  end

  def acid
    self.available_characteristic_id
  end

  def has_options
    self.available_characteristic.options.present?
  end

  private
  	def get_group
  		self.group = self.available_characteristic.group rescue nil
  	end

end
