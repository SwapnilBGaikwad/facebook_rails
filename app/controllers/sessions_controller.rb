class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to users_path
    end
  end
  
  def create
    @user = User.where("email_id = ?  AND password = ? " , session_params[:email_id] , session_params[:password])
    
    if @user.count == 1
      session[:user] = @user.find_by(1)
      session[:user_id] = @user.find_by(1).id
      redirect_to users_path
    else
      session[:user] = nil
      session[:user_id] = nil
      render 'new'
    end
  end
  
  def destroy
    session[:user] = nil
    session[:user_id] = nil
    redirect_to new_session_path
  end
  
  private
  
  def session_params
    params.require(:session).permit(:email_id , :password)
  end
end
