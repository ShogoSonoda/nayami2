class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text       :text, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
