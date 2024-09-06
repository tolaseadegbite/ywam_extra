class AddNullConstraintsToPodcasts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :podcasts, :followers_count, false
    change_column_null :podcasts, :episodes_count, false
  end
end
