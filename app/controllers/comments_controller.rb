class CommentsController < ApplicationController
  def new
  end
  
  def create 
    @comment = Comment.new
    @comment.body = comment_params[:body]
    @comment.user_id = session[:user_id]
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to :users
    else
      render plain: 'failed'
    end
  end
  
  private 
  def comment_params
    params.require(:comment).permit(:body)
  end
end
