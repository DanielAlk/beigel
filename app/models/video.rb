class Video < ActiveRecord::Base
  belongs_to :mediable, polymorphic: true
  enum format: [ :youtube ]

  def embed_url
  	url = self.url
  	url['watch?v=']= 'embed/' if url['watch?v=']
  	url
  end
end
