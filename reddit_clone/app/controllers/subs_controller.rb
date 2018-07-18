class SubsController < ApplicationController
  before_action :require_logged_in
  before_action :require_to_be_moderator, only: [:edit]
  
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to new_sub_url
    end
  end
  
  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  def new
    @sub = Sub.new
    render :new
    
  end
  
  def index
    @subs = Sub.all
    render :index
    
  end
    
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end
  
  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to edit_sub_url(@sub)
    end
    
  end
  
  private
  
  def sub_params
    params.require(:sub).permit(:title, :description)
    
  end
  
  def require_to_be_moderator
    redirect_to sub_url(params[:id]) unless !!current_user.subs.find_by(id: params[:id]) 
  end
end
