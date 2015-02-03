class UserInviter
  def invite(email)
    user = User.create(email: email, access_token: "asdf")
    "asdf"
  end
end