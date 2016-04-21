class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :location
      t.text :commet
      t.string :day

      t.timestamps null: false
    end
  end
end
