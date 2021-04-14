module Api
  module V1
    class EmpathiesController < ApplicationController
      skip_forgery_protection

      def create
        empathy = current_user.empathies.create!(post_id: params[:post_id])
        render json: { empathy_id: empathy.id }
      end

      def destroy
        Empathy.find(params[:id]).destroy!
        render json: { }
      end
    end
  end
end
