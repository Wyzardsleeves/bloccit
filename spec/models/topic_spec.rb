require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:name){RandomData.random_sentence}
  let(:description){RandomData.random_paragraph}
  let(:public){true}  #ask Jason about this
  let(:topic){Topic.create!(name: name, description: description)}

  it{should have_many(:posts)}
  it{should validate_length_of(:name).is_at_least(5)}
  it{should validate_length_of(:description).is_at_least(15)}
  it{should validate_presence_of(:name)}
  it{should validate_presence_of(:description)}

  # confirms that a topic responds to the appropriate attribute
  describe "attributes" do
    it "has name, description, and public attributes" do
      expect(topic).to have_attributes(name: name, description: description, public: public)
    end
    it "should respond to description" do
      expect(topic).to respond_to(:description)
    end
    it "should respond to public" do
      expect(topic).to respond_to(:public)
    end
    # confirms that the public attribute is set to true by default
    it "is public by default" do
      expect(topic.public).to be(true)
    end
  end #describe "attributes"
end #RSpec.describe Topic
