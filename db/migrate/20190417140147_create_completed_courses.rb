class CreateCompletedCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :completed_courses do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :course, foreign_key: true

      t.timestamps
    end
  end
end
