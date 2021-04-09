class EmpathiesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_post, only: [:create, :destroy]

  def create
    empathy = current_user.empathies.create(post_id: params[:post_id])
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end

    @post.create_notification_empathy!(current_user)
  end

  def destroy
    empathy = Empathy.find_by(post_id: params[:post_id], user_id: current_user.id)
    empathy.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
end
