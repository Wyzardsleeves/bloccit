require 'rails_helper'

RSpec.describe Comment do
  let(:post){Post.create!(title: "New Post Title", body: "New Post Body")}
  let(:comment){Comment.create!(body: 'Comment Body', post: post)}

  describe "attribtes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment Body")
    end
  end #describe "attributes"
end #Rspec.describe Comment
