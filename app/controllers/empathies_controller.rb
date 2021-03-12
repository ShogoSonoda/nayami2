class EmpathiesController < ApplicationController
  def create
    empathy = current_user.empathies.build(post_id: params[:post_id])
    empathy.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    empathy = Empathy.find_by(post_id: params[:post_id], user_id: current_user.id)
    empathy.destroy
    redirect_back(fallback_location: root_path)
  end
end
