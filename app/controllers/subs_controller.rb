class SubsController < ApplicationController
  before_action :require_current_user, except: [:index, :show]
  # before_action :require_moderator, only: [:edit, :update, :destroy]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to subs_url
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    if @sub.nil?
      flash[:errors] = "no such sub found"
      redirect_to sub_url(params[:id])
    else
      require_moderator
      render :edit
    end
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.nil?
      flash[:errors] = "no such sub found"
      redirect_to subs_url
    elsif @sub.update(sub_params)
      redirect_to sub_url(paramas[:id])
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def index
    @subs = Sub.all
    render :index
  end

private

  # def require_moderator
  #   unless @sub.moderator_id == current_user.id
  #     flash[:errors] = "You need to be the moderator to edit/delete this sub."
  #     redirect_to subs_url
  #   end
  # end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
