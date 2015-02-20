class AddLoginAttemptsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :login_attempts, :integer, default: 0
  end
end
