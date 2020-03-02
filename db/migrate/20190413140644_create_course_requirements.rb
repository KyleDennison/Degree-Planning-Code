class CreateCourseRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :course_requirements do |t|
      t.references :course, foreign_key: true
      t.references :requirement, foreign_key: true

      t.timestamps
    end
  end
end
