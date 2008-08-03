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
    return content_tag(:span, link_to("#{starred ? 'unstar' : 'star'} this post", path, :class => item.starred_class(current_user)), :class => "star")
  end
end
