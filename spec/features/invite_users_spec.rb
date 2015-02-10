require "user_inviter"

describe "Inviting Users" do
  before(:each) do
    DatabaseCleaner.clean
  end

  def find_user(email)
    User.find_by(:email => email)
  end

  let(:inviter) do
    UserInviter.new()
  end

  let!(:result) { inviter.invite(email) }
  let(:email) { "zee@example.com" }

  context "a valid invitation" do
    it "creates the user" do
      expect(find_user(email)).to be_present
    end

    it "returns the decrypted access token" do
      expect(result).not_to be_empty
    end

    it "encrypts the access token on the user" do
      expect(find_user(email).access_token_digest).not_to eql result
    end

    it "generates a random access token" do
      person_a_access_token = inviter.invite("person-a@example.com")
      person_b_access_token = inviter.invite("person-b@example.com")

      expect(person_a_access_token).not_to eql(person_b_access_token)
    end
  end

  context "when invite is invalid" do
    it "returns an array of reasons why the invite was invalid" do
      errors = inviter.invite(email)
      expect(errors.length).to eql(1)
      expect(errors).to include "Email has already been taken"
    end
  end
end
