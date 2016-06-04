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
  # before_action :require_author, only: [:edit, :update, :destroy]

  def index
    if params[:sub]
      this_sub = Sub.find_by(title: params[:sub])
      if this_sub.nil?
        flash[:errors] = "Invalid Sub Name"
        @posts = []
        render :index
      else
        @posts = this_sub.posts
        render :index
      end
    else
      @posts = Post.all
      render :index
    end
  end


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.sub_ids = params[:post][:sub_ids]
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post.id)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.nil?
      flash[:errors] = "no post found"
      redirect_to subs_url
    else
      render :edit
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.sub_ids = params[:post][:sub_ids]

    if @post.update(post_params)
      redirect_to post_url(@post.id)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    Post.find(parmas[:id]).destroy
    redirect_to posts_url
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments.includes(:author)
  end

  private

  # def require_author
  #   unless @post.author_id == current_user.id
  #     flash[:errors] = "You need to be the author to edit/delete this post."
  #     redirect_to sub_url
  #   end
  # end


  def post_params
    params.require(:post).permit(:title, :content, :url)
  end
end
