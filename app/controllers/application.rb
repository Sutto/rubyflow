# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '????? you'll need to sort this out yourself!'
  
  include AuthenticatedSystem
  
  def go_404
    render :text => '404 Not Found', :status => 404
  end
  
  def items_per_page
    50
  end
  helper_method :items_per_page
  
  # do_pagination is used in before_filters by actions that use pagination
  # If a "page" param is provided, use that to set the page, otherwise assume we're on page 1
  # Then set up a pagination_options hash that can be used with 'find' to sort out the SQL!
  # If param "all" is set, pagination is forgotten and ALL items should be returned
  def do_pagination
    @page_number = 1
    if params[:page] && params[:page].to_i > 0
      @page_number = params[:page].to_i
    end
    @pagination = true
    @pagination_options = { :limit => items_per_page, :offset => (@page_number - 1) * items_per_page }
    @pagination_options = {} if params[:all]
  end
end
