module NotificationsHelper

  def notification_form(notification)
    @comment = nil
    visitor = link_to notification.visitor.nickname, notification.visitor
    your_post = link_to "あなたの投稿", notification.post
    case notification.action
      when "follow" then
        "#{visitor}があなたをフォローしました。"
      when "empathy" then
        "#{visitor}が#{your_post}に共感しました。"
      when "comment" then
        @comment = Comment.find_by(id: notification.comment.id)&.text
        "#{visitor}が#{your_post}にコメントしました。"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
