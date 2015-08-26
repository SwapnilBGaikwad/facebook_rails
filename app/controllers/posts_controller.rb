class PostsController < ApplicationController
  
  def new
  end
  
  def create
    @post = Post.new
    @post.body = post_params[:body]
    
    @post.user_id = params[:user_id]
    if @post.save
      redirect_to users_path
    else
      render 'new' 
    end
  end
  
  def destroy
    @post = Post.find_by_id(params[:id])
    @post.delete
    redirect_to users_path
  end
  
  def edit
    @post = Post.find_by_id(params[:id])
    @user = current_user
  end
  
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:body , :id)
  end
end
