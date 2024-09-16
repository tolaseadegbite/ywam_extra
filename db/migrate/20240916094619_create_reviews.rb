class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :comment, null: false
      t.references :reviewable, polymorphic: true, null: false
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end

    add_index :reviews, [:account_id, :reviewable_type, :reviewable_id], unique: true, name: 'unique_review_per_account_per_item'
  end
end
