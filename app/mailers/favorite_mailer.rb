class FavoriteMailer < ApplicationMailer
  default from: "jlattimor3@gmail.com"

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@desolate-ocean-52857.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@desolate-ocean-52857.example>"
    headers["References"] = "<post/#{post.id}@desolate-ocean-52857.example>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@desolate-ocean-52857.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@desolate-ocean-52857.example>"
    headers["References"] = "<post/#{post.id}@desolate-ocean-52857.example>"

    @post = post

    mail(to: post.user.email, subject: "You're following, #{post.title}")
  end
end
