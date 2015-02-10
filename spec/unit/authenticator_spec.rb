require 'spec_helper'
require 'authenticator'

describe Authenticator do
  let(:authenticator) { Authenticator.new(user_store) }
  let(:user_store) { double("Users") }

  describe("#authenticate(email, access_token)") do
    before() {
      allow(user_store).to receive(:find_by).with({ email: email }).and_return(user)
    }
    subject(:result) { authenticator.authenticate(email, access_token) }

    context "When a user does not exist with the given email" do
      let(:email) { "not-found-user@example.com" }
      let(:user) { nil }
      let(:access_token) { "asdf" }

      it { should eql(false) }
    end

    context "when the user exists with the given email" do
      let(:email) { "real-user@example.com"}
      let(:user) { double("FakeUser", access_token: "token") }

      context "and the access token provided is correct" do
        let(:access_token) { "token" }

        it { should eql(user)}
      end
      context "and the access token provided is incorrect" do
        let(:access_token) { "wrong" }

        it { should eql(false) }
      end
    end
  end
end
