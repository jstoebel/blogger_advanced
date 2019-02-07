require 'rails_helper'

describe Commentable do
  describe '#has_comments?' do
    it 'returns true when there are comments' do
      article = Fabricate.build(:article)
      comments = Array.new(2) { Fabricate.build :comment }
      allow(article).to receive(:comments).and_return(comments)
      expect(article.has_comments?).to be_truthy
    end
  end
end
