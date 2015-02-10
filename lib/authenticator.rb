# Retrieve a user from a user store with a provided email and access token.
#
# Example:
#    > Authenticator.new(User).authenticate("found-user@example.com", "real-token")
#    => <User id: 1, email: "found-user@example.com", ...>"
#    > Authenticator.new(User).authenticate("found-user@example.com", "wrong-token")
#    => nil
#    > Authenticator.new(User).authenticate("not-found-user@example.com", "real-token")
#    => nil

class Authenticator

  # Initializes an authenticator with a User store to retrieve users from.
  #
  # @param user_store [#find_by] Likely an ActiveRecord::Model.
  def initialize(user_store)
    @user_store = user_store
  end

  # Retrieves a user with the given user and access token from the user store.
  # False if no user has that access token.
  #
  # @param email <String> Email to find for a given user.
  # @param access_token <String> Access token to compare against.
  # @return [User, false]
  def authenticate(email, access_token)
    user = user_store.find_by(email: email)
    if user && user.access_token == access_token
      user
    else
      false
    end
  end

  private
  attr_reader :user_store
end