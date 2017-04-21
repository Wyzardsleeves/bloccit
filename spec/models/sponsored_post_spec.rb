require 'rails_helper'
include RandomData

RSpec.describe SponsoredPost, type: :model do
  let(:name){RandomData.random_sentence}
  let(:price){RandomData.random_paragraph}
  let(:title){RandomData.random_sentence}
  let(:body){RandomData.random_paragraph}
  #
  let(:topic){Topic.create!(name:name, price: price)}
  #
  let(:sponsored_post){topic.posts.create!(title: title, body: body, price: price)}

  it{is_expected.to belong_to(:topic)}

  #tests whether post has attriutes named title and body.
  describe "attributes" do
    it "has title, body and price attribute" do
      expect(post).to have_attributes(title: title, body: body, price: price)
    end
  end #describe "attributes"
end
