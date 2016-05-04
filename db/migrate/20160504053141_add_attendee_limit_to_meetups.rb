class AddAttendeeLimitToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :attendee_limit, :integer
  end
end
