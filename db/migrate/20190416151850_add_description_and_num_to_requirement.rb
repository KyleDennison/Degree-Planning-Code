class AddDescriptionAndNumToRequirement < ActiveRecord::Migration[5.2]
  def change
    add_column :requirements, :description, :text
    add_column :requirements, :num_required, :integer
  end
end
