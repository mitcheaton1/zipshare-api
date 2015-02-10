class User < ActiveRecord::Base
  validates :email, email: true, uniqueness: { case_sensitive: false }

  def access_token=(access_token)
    self.access_token_digest = @access_token = BCrypt::Password.create(access_token)
  end

  def access_token
    @access_token ||= BCrypt::Password.new(access_token_digest)
  end
end
