class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    comment = Comment.new(comment_params)
    post = comment.post
    if comment.save
      post.create_notification_comment!(current_user, comment.id)
      flash[:success] = "コメントの投稿に成功しました。"
    else
      flash[:danger] = "コメントの投稿に失敗しました。"
    end
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "コメントの削除に成功しました。"
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id).merge(user_id: current_user.id)
  end
end
