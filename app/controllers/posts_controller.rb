class PostsController < ApplicationController
  #uses a before_action filter to call the require_sign_in method before each of our controller actions
  before_action :require_sign_in, except: :show

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    #creates an instance variable (@post) then assigns it to an empty post.
    @post = Post.new
  end

  def create
    #calls Post.new to create a new instance of Post
    @topic = Topic.find(params[:topic_id])

    @post = @topic.posts.build(post_params)
    @post.user = current_user
    #if Post is successfully saved displays a success message using flash[:notice]
    if @post.save
      #assigns
      flash[:notice] = "Post was saved."
      #changes the redirect to use the nested post path.
      redirect_to [@topic, @post]
    else
      #
      flash.now[:alert] = "There was an error saving the post. Please try again"
      render :new
    end #if @post.save
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again"
      render :edit
    end #if @post.save
  end #def update

  def destroy
    @post = Post.find(params[:id])
    #
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end #class PostsController < ApplicationController
