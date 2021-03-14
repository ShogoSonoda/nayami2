class EmpathiesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    empathy = current_user.empathies.build(post_id: params[:post_id])
    empathy.save
    post = Post.find(params[:post_id])
    post.create_notification_empathy!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    empathy = Empathy.find_by(post_id: params[:post_id], user_id: current_user.id)
    empathy.destroy
    redirect_back(fallback_location: root_path)
  end
end
