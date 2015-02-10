require 'spec_helper'
require 'authenticator'

describe Authenticator do
  let(:authenticator) { Authenticator.new(user_store) }

  describe("#authenticate(email, access_token)") do
    it "Returns false if the user does not exist" do
      result = Authenticator.new(->(attributes) { nil }).authenticate("non-existant-user@example.com", "not-existant-token")
      expect(result).to eql(false)
    end

    it "Returns false if the user exists but the access token is invalid" do
      user = double("User", access_token: "token")
      result = Authenticator.new(->(attributes) { user }).authenticate("existant-user@example.com", "not-existant-token")
      expect(result).to eql(false)
    end

    it "Returns the user if the user exists and the access token matches" do
      user = double("User", access_token: "token")
      result = Authenticator.new(->(attributes) { user }).authenticate("existant-user@example.com", "token")
      expect(result).to eql(user)
    end
  end
end
