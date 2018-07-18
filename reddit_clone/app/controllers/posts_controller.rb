class PostsController < ApplicationController
  before_action :require_logged_in
  before_action :require_to_be_author, only: [:edit]
  
  def new
    @post = Post.new
    render :new
  end
  
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    
    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to new_post_url
    end
  end
  
  def show
    @post = Post.find(params[:id])
    render :show
  end
  
  
  
  def index
    @posts = Sub.all
    render :index
  
  end
  
  def edit
    @post = Sub.find(params[:id])
    render :edit
  end
  
  def update
    @post = Sub.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to edit_post_url(@post)
    end
  
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  
  end
  
  def require_to_be_moderator
    redirect_to subs_url unless !!current_user.posts.find_by(id: params[:id]) 
  end
  
end
