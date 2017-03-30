require 'rails_helper'

RSpec.describe Post, type: :model do
  #using the let method, create a new instance of Post class
  let(:name){RandomData.random_sentence}
  let(:description){RandomData.random_paragraph}
  let(:title){RandomData.random_sentence}
  let(:body){RandomData.random_paragraph}
  #
  let(:topic){Topic.create!(name:name, description: description)}
  #
  let(:post){topic.posts.create!(title: title, body: body)}

  it{is_expected.to belong_to(:topic)}

  #tests whether post has attriutes named title and body.
  describe "attributes" do
    it "has title and body attribute" do
      expect(post).to have_attributes(title: title, body: body)
    end
  end #describe "attributes"
end #RSpec.describe Post
