xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title(APP_CONFIG[:app_title])
    xml.link(APP_CONFIG[:app_url])
    xml.description(APP_CONFIG[:sub_title])
    xml.language('en-us')

    for item in @items.first(10)
			next unless item.user_id
			next unless item.user.approved_for_feed == 1
      xml.item do
        xml.title(item.title)
        xml.description(item.content)
        xml.pubDate(item.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link(APP_CONFIG[:app_url] + "items/" + item.id.to_s)
        xml.guid(APP_CONFIG[:app_url] + "items/" + item.id.to_s)
      end
    end
  }
}
