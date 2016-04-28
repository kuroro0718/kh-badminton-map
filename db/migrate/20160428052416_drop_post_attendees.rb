class DropPostAttendees < ActiveRecord::Migration
  def change
    drop_table :post_attendees
  end
end
