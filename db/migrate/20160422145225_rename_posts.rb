class RenamePosts < ActiveRecord::Migration
  def change
    rename_column :posts, :location, :address
  end
end
