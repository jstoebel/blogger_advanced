require 'rails_helper'

describe TextContent do
  context ".total_word_count" do
    it "gives the word count for all articles" do
      2.times { Fabricate(:article, :body => "I think that...") }

      expect(Article.total_word_count).to eq(6)
    end
  end

  context "#word_count" do
    it "gives the total number of words" do
      article = Fabricate(:article, :body => "Four score and seven years ago...")
      expect(article.word_count).to eq(6)
    end
  end
end
