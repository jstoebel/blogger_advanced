require 'rails_helper'

describe Dashboard do
  let(:dashboard) { Dashboard.new }

  facade_methods = [
    { klass: Article, methods: %i[total_word_count most_popular] },
    { klass: Comment, methods: %i[total_word_count count] }
  ]

  facade_methods.each do |class_hash|
    class_hash[:methods].each do |method|
      klass = class_hash[:klass]
      facade_method = "#{klass.name.downcase}_#{method}"
      describe "##{facade_method}" do
        it "calls #{method} on #{klass}" do
          mock_facade_method klass, method
          dashboard.send facade_method
        end
      end
    end
  end

  describe '#total_words' do
    it 'gets total words' do
      article_count = double('article')
      comment_count = double('comment')
      mock_facade_method Article, :total_word_count, ret_val: article_count
      mock_facade_method Comment, :total_word_count, ret_val: comment_count
      expect(article_count).to receive(:+).with(comment_count)
      dashboard.total_words
    end
  end

  describe '#articles_for_dashboard' do
    it 'gets the article for the dashboard' do
      ordered = double('ordered')
      expect(Article).to receive(:order)
        .with('created_at DESC')
        .and_return(ordered)
      expect(ordered).to receive(:limit).with(5)
      dashboard.articles_for_dashboard
    end
  end

  describe '#comments_for_dashboard' do
    it 'gets the comments for the dashboard' do
      ordered = double('ordered')
      expect(Comment).to receive(:order)
        .with('created_at DESC')
        .and_return(ordered)
      expect(ordered).to receive(:limit).with(5)
      dashboard.comments_for_dashboard
    end
  end

  # test that a faceade method is wired up to the class that delegated it
  # Object: the class being mocked
  # message(:symbol) the message expected to be passed to object
  #
  # the assumption here is that all underlying methods are the same as
  # the delegated ones with the objects name prefixed. example my_method -> article_my_method
  def mock_facade_method(object, message, ret_val: nil)
    expect(object).to receive(message).and_return(ret_val)
  end
end
