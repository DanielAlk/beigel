class Video < ActiveRecord::Base
  belongs_to :mediable, polymorphic: true
  validates_uniqueness_of :url, scope: :mediable
  validates_format_of :url, :with => /\A(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+\Z/
  enum format: [ :youtube ]

  def embed_url
  	url = self.url
  	url['watch?v=']= 'embed/' if url['watch?v=']
  	url
  end
end
