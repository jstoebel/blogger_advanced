class Comment < ActiveRecord::Base
  include TextContent
  belongs_to :article
  validates :article_id, :presence => true
end
