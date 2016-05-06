class Image < ActiveRecord::Base
	has_attached_file :item, styles: { big: "1440x533#", medium: "613x288#", thumb: "270x197#" }, default_url: "card-image-1.jpg"
  validates_attachment_content_type :item, content_type: /\Aimage\/.*\Z/
  belongs_to :imageable, polymorphic: true
  acts_as_list scope: :imageable
end
