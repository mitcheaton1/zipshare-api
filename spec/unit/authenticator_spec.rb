require 'spec_helper'
require 'authenticator'

describe Authenticator do
  let(:authenticator) { Authenticator.new(user_store) }
  let(:user_store) { double("Users") }
  before() {
    allow(user_store).to receive(:find_by).with({ email: email }).and_return(user)
  }
  describe("#authenticate") do
    context "When a user does not exist with the given email" do
      let(:email) { "not-found-user@example.com" }
      let(:user) { nil }
      it "Returns false" do
        expect(authenticator.authenticate(email, "asdf")).to eq(false)
      end
    end

    context "when the user exists with the given email" do
      let(:email) { "real-user@example.com"}
      let(:user) { double("FakeUser", access_token: "token") }
      context "and the access token provided is correct" do
        it "returns the user" do
          expect(authenticator.authenticate(email, "token")).to eql(user)
        end
      end
      context "and the access token provided is incorrect" do
        it "returns false" do
          expect(authenticator.authenticate(email, "wrong")).to eql(false)
        end
      end
    end
  end
end
