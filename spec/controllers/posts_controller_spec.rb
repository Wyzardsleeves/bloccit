require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  #creates a post and assigns it to my_post using let. Uses RandomData to give my_post a ransom title and body
  let(:my_post){Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)}

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_post] to @posts" do
      get :index
      #since our test created on post (my_post), we expect index to return an array of one item
      expect(assigns(:posts)).to eq([my_post])
    end
  end #describe "Get index"

  #checks to see if new Post object is created
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    #expects PostsController#new to render the posts new view.
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
    #expects the @post instance variable to be initalized by PostsController#new
    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end#decribe "GET new"

  describe "POST create" do
    #
    it "increases the number of Post by 1" do
      expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
    end
    #
    it "assigns the new post to @post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq Post.last
    end
    it "redirects to the new post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Post.last
    end
  end #describe "POST create"

  describe "GET show" do
    it "returns http success" do
      #passing {id: my_post.id} to show as a parameter via params hash
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      #set to expect the response to return the show view using the render_template
      get :show, {id: my_post.id}
      expect(response).to render_template :show
    end
    it "assigns my_post to @post" do
      get :show, {id: my_post.id}
      #set to expect the post to equal my_post because we call show
      expect(assigns(:post)).to eq(my_post)
    end
  end #describe "GET show"

=begin

  describe "GET edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end
=end

end #RSpec describe PostController
