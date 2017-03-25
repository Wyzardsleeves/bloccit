require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "attributes" do
    let(:question){Question.new(title: "New Question Title", body: "New Question Body", resolved: false)}

    it "should respond to title" do
      expect(question).to respond_to(:title)
    end

    it "should respond to body" do
      expect(question).to respond_to(:body)
    end

    it "should respond to resolved" do
      expect(question).to respond_to(:resolved)
    end
  end
end #RSpec.describe Question

=begin
require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question){Question.new(title: "New Question Body", body: "New Question Body", resolved: false)}

  it "should respond to title" do
    expect(question).to respond_to(:title)
  end

  it "should respond to body" do
    expect(question).to respond_to(:body)
  end

  it "should respond to resolved" do
    expect(question).to respond_to(:resolved)
  end
end #RSpec.describe Question

=end
