require 'rails_helper'

describe Comment do
  let(:comment) { Fabricate(:comment) }

  it "should be valid with valid attributes" do
    expect(comment).to be_valid
  end

  it "should respond to article" do
    expect(comment).to respond_to(:article)
  end

  it "must have a value in article_id" do
    comment.article_id = nil
    expect(comment).to_not be_valid
  end

  context ".total_word_count" do
    it "gives the word count for all comments" do
      2.times { Fabricate(:comment, :body => "I think that...") }

      expect(Comment.total_word_count).to eq(6)
    end
  end

  context "#word_count" do
    it "gives the total number of words" do
      comment = Fabricate(:article, :body => "Four score and seven years ago...")
      expect(comment.word_count).to eq(6)
    end
  end
end
