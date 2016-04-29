class Characteristic < ActiveRecord::Base
  belongs_to :characterizable, polymorphic: true
  belongs_to :available_characteristic
end
