class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each_with_index do |post, index|
      post.title = "SPAM" if index % 5 == 0
    end #each_with_index
  end #index

  def show
    @post = Post.find(params[:id])
  end

  def new
    #creates an instance variable (@post) then assigns it to an empty post.
    @post = Post.new
  end

  def create
    #calls Post.new to create a new instance of Post
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    #if Post is successfully saved displays a success message using flash[:notice]
    if @post.save
      #assigns
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      #
      flash.now[:alert] = "There was an error saving the post. Please try again"
      render :new
    end #if @post.Save
  end

  def edit
  end
end
