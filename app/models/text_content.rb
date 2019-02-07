module TextContent
  extend ActiveSupport::Concern

  def word_count
    body.split.count
  end

  module ClassMethods
    def total_word_count
      all.inject(0) {|total, a| total += a.word_count }
    end
  end

  included do
    has_one :moderator_approval, as: :content
  end
end
