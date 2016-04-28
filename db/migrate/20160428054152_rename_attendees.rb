class RenameAttendees < ActiveRecord::Migration
  def change
    rename_column :attendees, :post_id, :meetup_id
  end
end
