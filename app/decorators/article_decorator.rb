class ArticleDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
  include IconLinkDecorations

  PUBLIC_ATTRIBUTES = %i[title body created_at].freeze
  ADMIN_ATTRIBUTES = PUBLIC_ATTRIBUTES + [:updated_at]

  def created_at_formatted
    article.created_at.strftime('%m/%d/%Y - %H:%M')
  end

  def comments_count
    h.pluralize(article.comments.count, 'Comment')
  end

  def to_json
    attrs_to_use = if h.current_user_is_admin?
                     ADMIN_ATTRIBUTES
                   else
                     PUBLIC_ATTRIBUTES
                   end
    object.slice(*attrs_to_use).to_json
  end
end
