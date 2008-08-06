class Category < ActiveRecord::Base
  acts_as_tree :order => 'name'
  
  validates_presence_of     :title, :parent_id
  validates_length_of       :title, :within => 4..255
  
  validates_uniqueness_of   :name, :if => :name?
  validates_format_of       :name, :with => /^[\w\-\_]+$/, :if => :name?, :message => 'is invalid (alphanumerics, hyphens and underscores only)'
  validates_length_of       :name, :within => 4..255, :if => :name?
  
  def to_param
    self[:name] && self[:name].length > 3 ? self[:name] : self[:id]
  end
  
  def publicly_facing_name
    title && title.length > 2 ? title : name
  end
end
