class AddReviewsCountToPodcasts < ActiveRecord::Migration[7.1]
  def change
    add_column :podcasts, :reviews_count, :integer, default: 0
  end
end
