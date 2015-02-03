require "user_inviter"

describe "Inviting Users" do
  before(:each) do
    DatabaseCleaner.clean
  end

  context "With a valid email address" do
    it "creates the user" do
      inviter = UserInviter.new()
      result = inviter.invite("zee@example.com")

      expect(User.find_by(email: "zee@example.com")).to be_present
    end

    it "returns the access token" do
      inviter = UserInviter.new()
      result = inviter.invite("zee@example.com")

      expect(result).not_to be_empty
      expect(User.find_by(email: "zee@example.com").access_token).to eql result
    end

    it "generates a random access token" do
      inviter = UserInviter.new()
      result = inviter.invite("zee@example.com")
      user = User.find_by(email: "zee@example.com")
      user.update_attributes(access_token: User.generate_token)
      updated_user = User.find_by(email: "zee@example.com")

      expect(result).not_to eql updated_user.access_token
    end
  end

  context "without a valid email address" do
    it "doesn't create the user"
    it "returns an error message"
  end

  context "when the email address is already taken" do
    it "doesn't create the user"
    it "doesn't return anything"
  end
end
