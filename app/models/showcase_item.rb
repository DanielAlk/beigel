class ShowcaseItem < ActiveRecord::Base
  belongs_to :showcaseable, polymorphic: true
  validates :showcaseable_id, uniqueness: { scope: :showcaseable_type }

  def cover
  	self.showcaseable.images.first.item.url(:big)
  end

  def title
  	self.showcaseable.title
  end

  def address
  	self.showcaseable.address
  end

  def short
  	self.showcaseable.short
  end

  def development?
    self.showcaseable.class == Development
  end

  def property?
    self.showcaseable.class == Property
  end

end
