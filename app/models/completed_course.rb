class CompletedCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :course_id, uniqueness: { scope: :user_id, message: "was already marked as complete."}
end
