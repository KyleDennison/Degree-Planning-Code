class AddFacultyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :faculty, :boolean, default: false
  end
end
