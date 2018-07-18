class CommentsController < ApplicationController
  
  def new
    
  end
  
  def create
    # byebug
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:comment][:post_id]
    byebug
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
    
    
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end
