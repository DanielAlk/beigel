class ShowcaseItem < ActiveRecord::Base
  belongs_to :showcaseable, polymorphic: true

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
end
