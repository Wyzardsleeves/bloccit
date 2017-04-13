module CommentsHelper
  def user_is_authorized_for_comment?(comment)
    current_user && (current_user == comment.user || comment_user.moderator? || comment_user.admin?)
  end
end
