class User < ActiveRecord::Base
  before_save :encrypt_token

  def encrypt_token
    self.access_token = BCrypt::Password.create(access_token)
  end

  def is_token?(unencrypted_token)
    BCrypt::Password.new(self.access_token) == unencrypted_token
  end
end
