class RenameAccountNamesField < ActiveRecord::Migration[7.1]
  def change
    rename_column :accounts, :firstname, :first_name
    rename_column :accounts, :surname, :last_name
  end
end
