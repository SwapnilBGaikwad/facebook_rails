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
      @search_user = User.find_by_id(current_user.id)
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
  
  def show
      @user_curr = current_user
      
      @user = User.find_by_id(params[:id])
      @friend1 = Friend.where('user_id = ? AND friend_id = ?  ' , @user_curr.id , @user.id)
      @friend2 = Friend.where('user_id = ? AND friend_id = ? ' , @user.id , @user_curr.id)
      @is_friend = true
      
      if session[:user_id].to_s != params[:id].to_s
        if @friend1.count == 1 || @friend2.count == 1 
          @is_friend = true
        else
          @is_friend = false
        end
      else
        @is_friend = true
      end
  end
  
  def add_friend
    @friend = Friend.new()
    @friend.friend_id = params[:id]
    @friend.user_id = session[:user_id]
    if @friend.save
      redirect_to root_path
    else
      render plain: 'Request failed.'
    end
  end
  
  def search_friend
    search_string = params[:search]
    if search_string != nil
      @searched_friends = User.where('first_name LIKE ?', "#{search_string}%")
    else
      @searched_friends = User.all
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name , :email_id , :password , :mobile_number , :college)
  end

  def show_params
    params.require(:user).permit(:id)
  end
end