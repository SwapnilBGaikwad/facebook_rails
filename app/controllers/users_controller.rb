class UsersController < ApplicationController
  #before_action :require_login
  
  def index
    if logged_in?
      @user = current_user
      @user_ids = Friend.where('friend_id = ?' , @user.id).select('user_id')
      @friend_ids = Friend.where('user_id = ? ' , @user.id).select('friend_id')
      @friends = User.where('id IN (?) OR id IN (?)',@user_ids,@friend_ids).select('first_name')
      @posts = Post.where('user_id IN (? , ?)' , @friends.ids , @user.id)
      @count = @posts.count
      @comments = Comment.where('post_id IN (?)' , @posts.ids)
    else
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