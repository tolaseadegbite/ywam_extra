class AddNullConstraintsToAccounts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :accounts, :username, false
    change_column_null :accounts, :first_name, false
    change_column_null :accounts, :last_name, false
    change_column_null :accounts, :dob, false
    change_column_null :accounts, :followers_count, false
    change_column_null :accounts, :following_count, false
  end
end
