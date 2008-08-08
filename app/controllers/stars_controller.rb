class StarsController < ApplicationController
  
	skip_before_filter :verify_authenticity_token
	before_filter :login_required
	
	def add
	  @item = Item.find(params[:item_id])
	  @star = Star.new(:item => @item, :user => current_user)
	  saved = @star.save
    respond_to do |wants|
      wants.html { redirect_to :back }
      wants.js do
        stars_count = @item.stars.size + 1
        saved ? render(:text => "#{stars_count} #{stars_count == 1 ? "star" : "stars"}") : head(:unprocessable_entity)
      end
    end
	end
	
	def remove
	  @item     = Item.find(params[:item_id])
	  @star     = @item.stars.find(:first, :conditions => ["user_id = ?", current_user.id])
	  destroyed = @star ? @star.destroy : false # If the star doesn't exist, add it
	  respond_to do |wants|
	    wants.html { redirect_to :back }
	    wants.js do
	      stars_count = @item.stars.size - 1
	      destroyed ? render(:text => "#{stars_count} #{stars_count == 1 ? "star" : "stars"}") : head(:unprocessable_entity)
	    end
	  end
	end
	
end