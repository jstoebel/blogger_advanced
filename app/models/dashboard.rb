class Dashboard
  delegate :total_word_count,
           :count,
           :most_popular,
           to: Article, prefix: :article

  delegate :total_word_count,
           :count,
           to: Comment, prefix: :comment

  def total_words
    article_total_word_count + comment_total_word_count
  end

  def articles_for_dashboard
    Article.order('created_at DESC').limit(5)
  end

  def comments_for_dashboard
    Comment.order('created_at DESC').limit(5)
  end
end
