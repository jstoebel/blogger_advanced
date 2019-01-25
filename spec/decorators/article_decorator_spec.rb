require 'spec_helper'

describe ArticleDecorator do
  describe '#created_at_formatted' do
    it 'formats created_at' do
      article = Fabricate.build(:article) do
        created_at {'1/1/2019'}
      end.decorate
      expect(article.created_at_formatted).to eq('01/01/2019 - 00:00')
    end
  end

  describe '#comments_count' do
    it 'displays comment count' do
      article = Fabricate(:article) do
        comments { Array.new(2) { Fabricate(:comment) } }
      end.decorate
      expect(article.comments_count).to eq('2 Comments')
    end
  end
end
