class AddFollowershipCountsToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :followers_count, :integer, default: 0
    add_column :accounts, :following_count, :integer, default: 0
  end
end
