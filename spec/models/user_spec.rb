require 'rails_helper'

describe User do
  describe "Validations" do
    it "validates uniquness of email" do
      email = "pete@example.com"
      user1 = User.create(email: email)
      user2 = User.create(email: email)

      expect(User.where(email: email).count).to equal(1)
      expect(user2.errors[:email]).to include "has already been taken"
    end

    it "is case insensitive in validating email uniqueness" do
      email = "pete@example.com"
      user1 = User.create(email: email)
      user2 = User.create(email: email.upcase)

      expect(user2).not_to be_valid
    end

    it "validates format of the email address" do
      email = "foo#gmailcom"
      user = User.create(email: email)

      expect(user).not_to be_valid
      expect(user.errors[:email]).to include "is invalid"
    end
  end
end
