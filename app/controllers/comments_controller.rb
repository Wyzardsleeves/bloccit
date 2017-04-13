class CommentsController < ApplicationController
  #uses require_sign_in to ensure that guest users are not permitted to creat comments
  before_action :require_sign_in
  #adds authorize_user filter to ensure that unauthorized users are not permittedd to delete comments
  before_action :authorize_user, only: [:destroy]

  def create
    #find the correct post using post_id and then create a new commeent using comment_params
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "comment saved successfully."
      #redirect to the posts show view
      redirect_to [@post.topic, @post]
    else
      false[:alert] = "Comment failed to save."
      #redirect to the posts show view
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment couldn't be deleted. Try again"
      redirect_to [@post.topic, @post]
    end
  end

  #we define a private comment_params method that white lists the parameters needed to create comments
  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  #we define the authorize_user method which allows the comment owner or an admin user to delete teh comment
  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end #def authorize_user
end #class CommentsController < ApplicationController
