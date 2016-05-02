class Characteristic < ActiveRecord::Base
  belongs_to :classifiable, polymorphic: true
  belongs_to :available_characteristic

  def title
  	self.available_characteristic.title
  end

  def group
  	self.available_characteristic.group
  end

end
