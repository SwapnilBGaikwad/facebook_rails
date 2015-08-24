class UsersController < ApplicationController
  #before_action :require_login
  
  def index
    if !logged_in?
      redirect_to root_path
    end
  end
  
  def new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user] = @user
      session[:user_id] = @user.id
      #render plain: user_params
      
      redirect_to users_path
    else
      render 'new'
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:first_name , :email_id , :password , :mobile_number , :college)
  end
end
