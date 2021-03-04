class RenamePositionColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :position, :position_id
  end
end
