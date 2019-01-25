class ArticleDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
  include IconLinkDecorations

  def created_at_formatted
    article.created_at.strftime('%m/%d/%Y - %H:%M')
  end

  def comments_count
    h.pluralize(article.comments.count, 'Comment')
  end
end
