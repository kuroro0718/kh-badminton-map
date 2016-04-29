class AddEventTimeToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :start_time, :string
    add_column :meetups, :end_time, :string
  end
end
