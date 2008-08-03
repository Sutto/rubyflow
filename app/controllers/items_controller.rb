class ItemsController < ApplicationController
  before_filter :login_required, :except => [:show, :list_for_tag, :index, :search, :category, :new, :create]
  before_filter :admin_required, :only => [:destroy]
  before_filter :permission_required, :only => [:edit, :update]  
  before_filter :do_pagination, :only => [:index, :list_for_tag, :list_for_tags, :search, :recently]
  
  layout 'main'
  
  # GET /items
  # GET /items.xml
  def index
    @front_page = true
    @items_count = Item.count
    @items = Item.find(:all, { :order => 'items.created_at DESC', :include => :user }.merge(@pagination_options))

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
      format.rss { render :layout => false }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id]) rescue Item.find_by_name(params[:id])
    
    if @item.title && @item.title.length > 2
      @title = @item.title
    else
      @title = @item.content.gsub(/\<.+?\>/, '')[0..40] + "..."
    end
    
    @comment = Comment.new(params[:comment])
    
    go_404 and return unless @item

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
      format.json { render :json => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item ||= Item.find(params[:id]) rescue Item.find_by_name(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])
    
    if logged_in?
      @item.user = current_user
    else
      @item.content = @item.content.gsub(/((<a\s+.*?href.+?\".*?\")([^\>]*?)>)/, '\2 rel="nofollow" \3>')
      @item.byline = "Anonymous Coward" if @item.byline.empty?
      if @item.byline.length > 18
        @item.errors.add("Byline")
        render :action => 'new'
        return
      end
    end
    
    if @item.title.empty?
      @item.title = @item.content.gsub(/\<[^\>]+\>/, '')[0...40] + "..."
    end
    
    unless logged_in?
      unless Digest::SHA1.hexdigest(params[:captcha].upcase.chomp)[0..5] == params[:captcha_guide]
        @item.errors.add("Word")
        render :action => 'new'
        return
      end
    end

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully posted.'
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item ||= Item.find(params[:id]) rescue Item.find_by_name(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item ||= Item.find(params[:id]) rescue Item.find_by_name(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  def list_for_tags
    @tag_array = [*params[:id]].collect { |a| a.split(/\s+|\++/) }.flatten
    @items_count = Item.count_all_for_all_tags(@tag_array)
    go_404 and return if @items_count == 0
    @items = Item.find_all_for_all_tags(@tag_array, { :order => 'created_at DESC' }.merge(@pagination_options))
    @noindex = true

    respond_to do |format|
      format.html
      format.xml  { render :xml => @items }
    end    
  end
  
  def search
    @items_count = Item.count(:conditions => ['title LIKE ? OR tags LIKE ?', "%#{params[:id]}%", "%#{params[:id]}%"])
    @items = Item.find(:all, {:conditions => ['title LIKE ? OR tags LIKE ?', "%#{params[:id]}%", "%#{params[:id]}%"]}.merge(@pagination_options))
    @noindex = true

    respond_to do |format|
      format.html
      format.xml  { render :xml => @items }
    end    
  end
  
  def category
    @category = Category.find_by_name(params[:id])
    go_404 and return unless @category
    @items = Item.find_all_for_all_tags(@category.query.split(/\s/))
  end
  
  def recently
    @last_checked_at = current_user.last_checked_at
    conditions = ['items.updated_at > ? or comments.created_at > ?', @last_checked_at, @last_checked_at]
    @items_count = current_user.starred_items.count(:conditions => conditions, :include => :comments)
    @items       = current_user.starred_items.find(:all, :conditions => conditions, :include => :comments)
    current_user.update_attribute :last_checked_at, Time.now
  end
  
  protected
  
  def permission_required
    @item = Item.find(params[:id]) rescue Item.find_by_name(params[:id])
    render :status => 404, :text => "404 Not Found" and return unless @item
    render :status => 403, :text => "403 Forbidden" and return unless @item.user_id == current_user.id || admin?
  end
  
end
