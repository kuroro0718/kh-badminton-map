class RenamePostsToMeetups < ActiveRecord::Migration
  def change
    rename_table :posts, :meetups
  end
end
