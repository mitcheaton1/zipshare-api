describe "/files" do
  let(:user) { User.create(user_credentials) }
  let(:user_credentials) { { email: "email@example.com", access_token: token } }
  let(:token) { "token" }

  context "posting as an authorized user" do
    it "responds with 201 with successful upload" do
      test_text_file_fixture = Rails.root.join("spec", "fixtures", "test.txt")
      file_params = { user: user, file: test_text_file_fixture,
                      title: "title", desc: "description" }

      post_as("/files", user_credentials, file_params)

      expect(response).to be_created
    end

    it "saves in designated file storage"
    it "belongs to authorized users file collection"
    it "returns files public information"
  end
end
