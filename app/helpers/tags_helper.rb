module TagsHelper
  def hashtag_meta(tag_name)
    tag('meta', name: 'hashtag', content: tag_name)
  end

  def love_or_unlove_button(tag)
    if current_user.loves?(tag)
      button_to "unlove", user_tag_path(id: tag.id), method: :delete
    else
      button_to "love", user_tags_path(id: tag.id)
    end
  end
end
