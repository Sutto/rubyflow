Factory.define :item do |item|
  item.title { Factory.next :title }
  item.name { Factory.next :name }
  item.content 'content' * 5
end