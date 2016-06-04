class SubsController < ApplicationController
  before_action :require_current_user, except: [:index, :show]

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
    if @sub.moderator_id == current_user.id
      render :edit
    else
      flash[:errors] = "You need to be a moderator to edit"
      redirect_to subs_url
    end
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.nil?
      render json: "no such sub exists"
    elsif @sub.update(sub_params)
      redirect_to subs_url
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
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
