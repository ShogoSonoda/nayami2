module Api
  module V1
    class EmpathiesController < ApplicationController
      def create
        empathy = current_user.empathies.create!(post_id: params[:post_id])
        render json: { empathy_id: empathy.id }
        @post = Post.find(params[:post_id])
        @post.create_notification_empathy!(current_user)
      end

      def destroy
        Empathy.find(params[:id]).destroy!
        render json: { }
      end
    end
  end
end
