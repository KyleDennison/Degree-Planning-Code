class CreateDeclaredPrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :declared_programs do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :major, foreign_key: true

      t.timestamps
    end
  end
end
