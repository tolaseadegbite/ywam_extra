class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :account, null: false, foreign_key: true
      t.text :body, null: false
      t.references :commentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
