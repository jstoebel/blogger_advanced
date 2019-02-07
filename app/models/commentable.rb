module Commentable
  extend ActiveSupport::Concern

  def has_comments?
    comments.any?
  end
  included do
    has_many :comments
  end
end
