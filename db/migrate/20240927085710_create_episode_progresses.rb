class CreateEpisodeProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :episode_progresses do |t|
      t.references :account, null: false, foreign_key: true
      t.references :episode, null: false, foreign_key: true
      t.float :progress

      t.timestamps
    end
  end
end
