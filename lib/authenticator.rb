# Retrieve a user from a user store with a provided email and access token.
#
# Example:
#    > authenticator = Authenticator.new(User.method(:find_by))
#    > authenticator.authenticate("found-user@example.com", "real-token")
#    => <User id: 1, email: "found-user@example.com", ...>"
#    > authenticator.authenticate("found-user@example.com", "wrong-token")
#    => nil
#    > authenticator.authenticate("not-found-user@example.com", "real-token")
#    => nil
class Authenticator
  # Initializes an authenticator with a User store to retrieve users from.
  #
  # @param user_finder [Lambda] Takes a hash of attributes to find a user with.
  def initialize(user_finder)
    @user_finder = user_finder
  end

  # Retrieves a user with the given user and access token from the user store.
  # False if no user has that access token.
  #
  # @param email <String> Email to find for a given user.
  # @param access_token <String> Access token to compare against.
  # @return [User, false]
  def authenticate(email, access_token)
    user = user_finder.call(email: email)
    if user && user.access_token == access_token
      user
    else
      false
    end
  end

  private

  attr_reader :user_finder
end
