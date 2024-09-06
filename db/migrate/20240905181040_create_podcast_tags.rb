class CreatePodcastTags < ActiveRecord::Migration[7.1]
  def change
    create_table :podcast_tags do |t|
      t.references :podcast, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
