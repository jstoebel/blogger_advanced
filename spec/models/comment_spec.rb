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
end
