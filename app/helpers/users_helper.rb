module UsersHelper
  def user_has_posts?(user)
    user.posts == true
  end

  def user_has_comments?(user)
    user.comments == true
  end

  def favorite_for(user)
    favorites.where(post_is: post.id).first
  end
end
