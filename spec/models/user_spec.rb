require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password")}

  it{is_expected.to have_many(:posts)}
  it{is_expected.to have_many(:comments)}
  it{is_expected.to have_many(:votes)}  #checkpoint-30

  #test for name
  it{is_expected.to validate_presence_of(:name)}
  it{is_expected.to validate_length_of(:name).is_at_least(1)}

  #test for email
  it{is_expected.to validate_presence_of(:email)}
  it{is_expected.to validate_uniqueness_of(:email)}
  it{is_expected.to validate_length_of(:email).is_at_least(3)}
  it{is_expected.to allow_value("user@bloccit.com").for(:email)}

  #test for password
  it{is_expected.to validate_presence_of(:password)}
  it{is_expected.to have_secure_password}
  it{is_expected.to validate_length_of(:password).is_at_least(6)}

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: "Bloccit User", email: "user@bloccit.com")
    end
    it "should_respond_to_email" do
      expect(user).to respond_to(:email)
    end
    it "should format the user's name" do
      user.name = "bloc user"
      user.save
      expect(user.name).to eq "Bloc User"
    end
    #expects that users will respond to role
    it "responds to role" do
      expect(user).to respond_to(:role)
    end
    #expects users will respond to admin? which will return whether or not a user is an admin
    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end
    #expects users will respond to member? which will return whether or not a user is a member
    it "responds to admin?" do
      expect(user).to respond_to(:member?)
    end
  end #describe "attributes"

  describe "roles" do
    #expects that users will be assigned the role of memeber by default
    it "is member default" do
      expect(user.role).to eql("member")
    end
    #test member and admin users within separate contexts
    context "member user" do
      it "returns true #member?" do
        expect(user.member?).to be_truthy
      end
      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end #context "member user"
    #test member and admin users within separate contexts
    context "admin user" do
      before do
        user.admin!
      end
      it "returns true #member?" do
        expect(user.member?).to be_falsey
      end
      it "returns false for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end #context "admin user"
  end #describe "roles"

  describe "invalid user" do
    let(:user_with_invalid_name){User.new(name: "", email: "user@bloccit.com")}
    let(:user_with_invalid_email){User.new(name: "Bloccit User", email: "")}

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end
    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

end #RSpec.describe User
