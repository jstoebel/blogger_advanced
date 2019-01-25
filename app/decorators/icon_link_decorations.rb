module IconLinkDecorations
  def delete_icon(link_text = nil)
    h.link_to icon_tag('cancel.png', link_text),
              h.polymorphic_path(object),
              method: :delete,
              confirm: "Delete '#{object}'?"
  end

  def edit_icon(link_text = nil)
    h.link_to icon_tag('page_edit.png', link_text),
              h.edit_polymorphic_path(object)
  end

  private

  # renders an icon with a label
  def icon_tag(file_name, text)
    image = h.image_tag(file_name)
    image += " #{text}" if text.present?
    image
  end
end
