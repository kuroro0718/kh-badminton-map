class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
