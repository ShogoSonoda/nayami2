class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def create
    comment = Comment.new(comment_params)
    post = comment.post
    if comment.save
      post.create_notification_comment!(current_user, comment.id)
      redirect_back(fallback_location: root_path) 
    else
      # エラー文を表示させる
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id).merge(user_id: current_user.id)
  end
end
