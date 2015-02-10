require 'user_inviter'

namespace :users do
  desc "invite user"
  task invite: :environment do
    email = ENV['EMAIL'].to_s
    puts UserInviter.new.invite(email)
  end
end