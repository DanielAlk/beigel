class Video < ActiveRecord::Base
  belongs_to :mediable, polymorphic: true
  enum format: [ :youtube ]
end
