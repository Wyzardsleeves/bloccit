class SponsoredPostsController < ApplicationController
  #This is the file that may need to be changed back to "singular"
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def create
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    @topic = Topic.find(params[:topic_id])
    #assigns topic to post
    @sponsored_post.topic = @topic
    #if Post is successfully saved displays a success message using flash[:notice]
    if @sponsored_post.save
      #assigns
      flash[:notice] = "SponsoredPost was saved."
      #changes the redirect to use the nested post path.
      redirect_to [@topic, @sponsored_post]
    else
      #
      flash.now[:alert] = "There was an error saving the sponsored_post. Please try again"
      render :new
    end #if @post.save
  end

  def

  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]

    if @sponsored_post.save
      flash[:notice] = "SponsoredPost was updated."
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash.now[:alert] = "There was an error saving the sponsored_post. Please try again"
      render :edit
    end #if @sponsored_post.save
  end

  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])
    #
    if @sponsored_post.destroy
      flash[:notice] = "\"#{@sponsored_post.title}\" was deleted successfully."
      redirect_to @sponsored_post.topic
    else
      flash.now[:alert] = "There was an error deleting the sponsored_post."
      render :show
    end
  end

end
