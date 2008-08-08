module ItemsHelper
  def user_link(item)
    if item.user
      follow = item.user.approved_for_feed == 1 ? {} : {:rel => 'nofollow'} 
      link_to(item.user.login, item.user.url, follow)
    else
      item.byline
    end
  end
  
  def star_link(item)
    starred = item.is_starred_by_user(current_user)
    path    = starred ? item_remove_star_path(item) : item_add_star_path(item)
    if starred
      return " &ndash; " + content_tag(:span, link_to("unstar this post", item_remove_star_path(item), :class => item.starred_class(current_user)), :class => "star")
    end
  end
  
  # Convert URLs in text automatically to links
  def auto_link(text)
    text.gsub(/ (http:\/\/[^ !,\?]+)/, ' <a href="\1">\1</a>')
  end
  
  # Shows the time left to edit the current item, or nil if it's always allowed
  def edit_time_left(item)
    diff = Time.now - item.updated_at
    expire_rate = APP_CONFIG[:edit_expiration_in_minutes].to_i
    return expire_rate > 0 ? expire_rate - (diff.to_i / 60) : nil
  end
  
end
