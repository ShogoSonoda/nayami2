module Api
  module V1
    class RelationshipsController < ApplicationController
      def create
        followed_user = User.find(params[:followed_id])
        relationship = current_user.follow(followed_user)
        followed_user.create_notification_follow!(current_user)
        render json: { relationship_id: relationship.id }
      end

      def destroy
        Relationship.find(params[:id]).destroy!
        render json: { }
      end
    end
  end
end
