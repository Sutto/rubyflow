# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def editable?(item)
    admin? || item.user == current_user
  end
  
  def title
    if @title
      @title + " : " + APP_CONFIG[:app_title]
    else
      APP_CONFIG[:default_title]
    end
  end
  
  def safe(txt)
    # Poor mans' sanitization!
    
    txt = h(txt)
    txt.gsub!(/\&quot;/, '"')
    txt.gsub!(/\&gt;/, '>')
    
    txt.gsub!(/\n/, '<br />')
    
    txt.gsub!(/\&lt;a href/, '<a href')
    txt.gsub!(/\&lt;\/a>/, '</a>')

    txt.gsub!(/\&lt;\/blockquote>/, '</blockquote>')
    txt.gsub!(/\&lt;\/code>/, '</code>')
    txt.gsub!(/\&lt;\/b>/, '</b>')
    txt.gsub!(/\&lt;\/strong>/, '</strong>')
    txt.gsub!(/\&lt;\/i>/, '</i>')
    txt.gsub!(/\&lt;\/em>/, '</em>')

    txt.gsub!(/\&lt;blockquote>/, '<blockquote>')
    txt.gsub!(/\&lt;code>/, '<code>')
    txt.gsub!(/\&lt;b>/, '<b>')
    txt.gsub!(/\&lt;strong>/, '<strong>')
    txt.gsub!(/\&lt;i>/, '<i>')
    txt.gsub!(/\&lt;em>/, '<em>')

    txt
  end
  
end
