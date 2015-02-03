class UserInviter
  def invite(email)
    user = User.create(email: email, access_token: User.generate_token)
    user.access_token
  end
end
