require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:name){RandomData.random_sentence}
  let(:description){RandomData.random_paragraph}
  let(:public){true}  #ask Jason about this
  let(:topic){Topic.create!(name: name, description: description)}

  # confirms that a topic responds to the appropriate attribute
  describe "attributes" do
    it "has name, description, and public attributes" do
      expect(topic).to have_attributes(name: name, description: description, public: public)
    end
    # confirms that the public attribute is set to true by default
    it "is public by default" do
      expect(topic.public).to be(true)
    end
  end #describe "attributes"
end #RSpec.describe Topic
