class FavoriteMailer < ApplicationMailer
  default from: "jlattimor3@gmail.com"

  def new_comment(user, post, comment)
=begin
    headers["Message-ID"] = "<comments/#{comment.id}@desolate-ocean-52857.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@desolate-ocean-52857.example>"
    headers["References"] = "<post/#{post.id}@desolate-ocean-52857.example>"
=end
    headers["Message-ID"] = "<comments/#{comment.id}@http://localhost:3000/>"
    headers["In-Reply-To"] = "<post/#{post.id}@http://localhost:3000/>"
    headers["References"] = "<post/#{post.id}@http://localhost:3000/>"

    @user = user
    @post = post
    @comment = comment

    mail(to: 'jlattimor3@gmail.com', subject: "New comment on #{post.title}")
    #mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(post)
    headers["Message-ID"] = "<posts/#{post.id}@http://localhost:3000/>"
    headers["In-Reply-To"] = "<post/#{post.id}@http://localhost:3000/>"
    headers["References"] = "<post/#{post.id}@http://localhost:3000/>"

    @post = post
    mail(to: 'jlattimor3@gmail.com', subject: "You're following, #{post.title}!")
    #mail(to: post.user.email, subject: "You're following, #{post.title}!")
  end
end
