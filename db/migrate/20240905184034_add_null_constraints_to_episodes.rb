class AddNullConstraintsToEpisodes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :episodes, :likes_count, false
    change_column_null :episodes, :saves_count, false
  end
end
