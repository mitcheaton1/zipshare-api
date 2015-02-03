class UserInviter
  def invite(email)
    token = SecureRandom.uuid
    user = User.create(email: email, access_token: token)
    token
  end
end
