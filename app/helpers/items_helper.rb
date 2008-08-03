module ItemsHelper
  def user_link(item)
    if item.user
      follow = item.user.approved_for_feed == 1 ? {} : {:rel => 'nofollow'} 
      link_to(item.user.login, item.user.url, follow)
    else
      item.byline
    end
  end
end
