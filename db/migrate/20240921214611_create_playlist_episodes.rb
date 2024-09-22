class CreatePlaylistEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :playlist_episodes do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :episode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
