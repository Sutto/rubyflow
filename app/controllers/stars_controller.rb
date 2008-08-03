class StarsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	             	
	def new
		@star = Star.new
		@star.user_id = params[:user_id]
		@star.item_id = params[:item_id]
		
		if(@star.save)
			@star.reload
			plural = @star.item.stars.size == 1 ? "star" : "stars"
			render :text => "#{@star.item.stars.size} #{plural}"			
		end
	end                                                     
	
	def destroy
		@star = Star.find_by_user_id_and_item_id(params[:user_id],params[:item_id])
		@count = @star.item.stars.size - 1
		if(@star.destroy) 
			plural = @count == 1 ? "star" : "stars"
			render :text => "#{@count} #{plural}"
		end
	end
	
end