class AddUniqueIndexToUsername < ActiveRecord::Migration[7.1]
  def change
    add_index :accounts, :username, unique: true
  end
end
