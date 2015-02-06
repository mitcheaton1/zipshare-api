# Invites a user, with their email and access token
class UserInviter

  # Creates a user with the given email and assigns them a UUID for a token
  # @param email [String]
  # @return [String, Array<Strings>] String on success, array of strings on failure.
  def invite(email)
    token = SecureRandom.uuid
    user = User.create(email: email, access_token: token)
    if user.valid?
      token
    else
      user.errors.full_messages
    end
  end
end
