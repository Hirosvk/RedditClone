class CommentsController < ApplicationController
  before_action :require_current_user

  def new
    @comment = Comment.new(post_id: params[:post_id])
    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def destroy
    comment = Comment.find(params[:id]).destroy
    redirect_to post_url(comment.post_id)
  end


private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end


end
