require 'rails_helper'

RSpec.describe Post, type: :model do
  #using the let method, create a new instance of Post class
  let(:name){RandomData.random_sentence}
  let(:description){RandomData.random_paragraph}
  let(:title){RandomData.random_sentence}
  let(:body){RandomData.random_paragraph}
  let(:topic){Topic.create!(name:name, description: description)}

  #creates a user to associate with a test post
  let(:user){User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld")}
  #associates user with post when we create the test post.
  let(:post){topic.posts.create!(title: title, body: body, user: user)}

  it{is_expected.to belong_to(:topic)}
  it{is_expected.to belong_to(:user)} #checkpoint 27

  # test that Post validates the presence of title, body, and topic
  it{is_expected.to validate_presence_of(:title)}
  it{is_expected.to validate_presence_of(:body)}
  it{is_expected.to validate_presence_of(:topic)}
  it{is_expected.to validate_presence_of(:user)}  #checkpoint 27

  it{is_expected.to validate_length_of(:title).is_at_least(5)}
  it{is_expected.to validate_length_of(:body).is_at_least(20)}

  #tests whether post has attriutes named title and body.
  describe "attributes" do
    it "has a title, body, and user attribute" do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  end #describe "attributes"
end #RSpec.describe Post
