class User < ActiveRecord::Base
  def self.generate_token
    BCrypt::Password.create(SecureRandom.urlsafe_base64)
  end
end
