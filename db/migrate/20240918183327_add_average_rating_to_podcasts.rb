class AddAverageRatingToPodcasts < ActiveRecord::Migration[7.1]
  def change
    add_column :podcasts, :average_rating, :decimal, default: 0
  end
end
