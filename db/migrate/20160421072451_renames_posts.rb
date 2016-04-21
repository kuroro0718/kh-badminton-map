class RenamesPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :commet, :comment
  end
end
