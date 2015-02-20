require "base64"
require "rails_helper"

describe "unauthorized/authorized request" do
  let(:user) { User.create(user_credentials.merge(last_activity_at: 10.years.ago, login_attempts: 2)) }
  let(:user_credentials) { { email: "email@example.com", access_token: token } }
  let(:token) { "token" }

  context "request with valid credentials" do
    before do
      user
      get_as("/", user_credentials)
    end

    it "returns status of 200" do
      expect(response).to be_ok
    end

    it "updates the user's most recent activity date" do
      expect(user.reload.last_activity_at).to be > 5.seconds.ago
    end

    it "resets the attempted login count" do
      expect(user.reload.login_attempts).to eq(0)
    end
  end

  context "request with invalid credientials" do
    it "returns status of 401" do
      get("/")

      expect(response).to be_unauthorized
    end

    it "responds with an error message in the body" do
      get("/")

      expect(response_json["errors"]).to include "invalid credentials"
    end

    it "increments the attempted login count" do
      (expect do
        get_as("/", user_credentials.merge(access_token: "wrong"))
      end).to change { user.reload.login_attempts }.by(1)
    end
  end

  def get_as(path, user_credentials)
    credentials_string = "#{ user_credentials[:email] }:#{ user_credentials[:access_token] }"
    headers = {
      "HTTP_AUTHORIZATION" => Base64.encode64(credentials_string) }
    # Act: Send a request to an API path with the login credentials
    get(path, {}, headers)
  end

  def response_json
    @response_json ||= JSON.parse(response.body)
  end
end
