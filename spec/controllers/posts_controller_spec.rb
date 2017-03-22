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

=begin
  describe "GET show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end
=end

end
