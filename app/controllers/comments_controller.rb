class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new comment_params.merge({user_id: current_user.id, post_id: params[:post_id]})
    @comment.save
    redirect_to post_path(params[:post_id])
  end

  def destroy
    comment = Comment.find params[:id]
    comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
