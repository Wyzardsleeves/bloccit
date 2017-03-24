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

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #edit view" do
      get :edit, {id: my_post.id}
      #expects the edit view to render when a post is edited
      expect(response).to render_template :edit
    end
    #tests that edit assigns the correct post to be updated to @post
    it "assigns post to be updated to @post" do
      get :edit, {id: my_post.id}
      post_instance = assigns(:post)

      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end #describe "GET edit"

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_post.id, post: {title: new_title, body: new_body}
      #tests that @post was updated with tthe title and body passed to update
      updated_post = assigns(:post)
      expect(updated_post.id).to eq my_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end
    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      #expects to be redirected to teh posts show veiw after the update
      put :update, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to redirect_to my_post
    end
  end #describe "PUT update"

  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, {id: my_post.id}
      #searches the database for a post with an id equal to my_post.id
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end

    it "redirects to posts index" do
      delete :destroy, {id: my_post.id}
      #expects to be redirected to teh posts index view after a post has been deleted
      expect(response).to redirect_to posts_path
    end
  end #describe "DELETE destroy"
end #RSpec describe PostController
