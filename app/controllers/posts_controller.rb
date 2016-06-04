# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text             not null
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
class PostsController < ApplicationController
  before_action :require_current_user, except: [:index, :show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.sub_id = params[:sub_id]
    @post.author_id = current_user.id
    if @post.save
      redirect_to sub_url(params[:sub_id])
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.nil?
      flash[:errors] = "no post found"
      redirect_to sub_url(params[:sub_id])
    else
      render :edit
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.nil?
      flash[:errors] = "no post found"
    elsif @post.update(post_params)
      redirect_to sub_url(params[:sub_id])
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  def show
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :url)
  end
end
