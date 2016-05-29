class Promotion < ActiveRecord::Base
  belongs_to :promotionable, polymorphic: true
  validates_presence_of :promotionable

  def development?
    self.promotionable.class == Development
  end

  def property?
    self.promotionable.class == Property
  end
end