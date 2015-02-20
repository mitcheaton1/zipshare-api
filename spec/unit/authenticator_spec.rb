require "spec_helper"
require "authenticator"

describe Authenticator do
  describe("#authenticate(email, access_token)") do
    def authenticate(finder, email, access_token)
      Authenticator.new(finder).authenticate(email, access_token)
    end

    it "Returns false if the user does not exist" do
      expect(authenticate(finder(nil), "non-existant-user@example.com", "token")).to eql(false)
    end

    it "Returns false if the user exists but the access token is invalid" do
      expect(authenticate(finder(user), "existant-user@example.com", "invalid-token")).to eql(false)
    end

    it "Returns the user if the user exists and the access token matches" do
      expect(authenticate(finder(user), "existant-user@example.com", "token")).to eql(user)
    end

    def finder(user)
      ->(_attributes) { user }
    end

    def user
      @user ||= double("User", access_token: "token", login_attempts: 0, update_attributes: true)
    end
  end
end
