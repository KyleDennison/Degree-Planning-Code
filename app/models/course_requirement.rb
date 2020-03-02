class CourseRequirement < ApplicationRecord

  # This is a join table. Don't touch anything here
  # unless you have a REALLY good reason.

  belongs_to :course
  belongs_to :requirement

end
