class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.text :short_body
      t.text :full_body

      t.timestamps
    end
  end
end
