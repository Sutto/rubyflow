class UsersController < ApplicationController
  before_filter :admin_required, :except => [:new, :create]
  
  layout 'main'
    
  def new
  end

  def create
    cookies.delete :auth_token
    
    @user = User.new(params[:user])
    unless Digest::SHA1.hexdigest(params[:captcha].upcase.chomp)[0..5] == params[:captcha_guide]
      @user.errors.add("Word")
      render :action => 'new'
      return
    end    

    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up! You have been logged in automagically!"
    else
      render :action => 'new'
    end
  end
  
  def index
    @users = User.find(:all, :order => 'id DESC', :limit => 100)
  end

  def approve
    user = User.find(params[:id])
    user.approved_for_feed = 1
    user.save
    redirect_to :back
  end

  def disapprove
    user = User.find(params[:id])
    user.approved_for_feed = 0
    user.save
    redirect_to :back
  end
  
  def destroy
    return unless request.post?
    User.destroy(params[:id])
  end
end
