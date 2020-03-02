class AddDescriptionToMajor < ActiveRecord::Migration[5.2]
  def change
    add_column :majors, :description, :text
  end
end
