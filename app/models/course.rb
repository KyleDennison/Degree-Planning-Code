class Course < ApplicationRecord

  # Use ancestry gem for handling prereqs
  has_ancestry

  # Join table for linking to many possible requirement areas
  has_many :course_requirements
  has_many :requirements, through: :course_requirements

  # Validations
  validates :title, presence: true, uniqueness: true

  # Get immediate prereq if one exists
  def immediate_prereq
    return self.children.first if self.has_children?
  end

  # Get all prereqs if they exist
  def all_prereqs
    return self.descendants if self.has_children?
  end

  # Get all relevant majors
  def all_majors
    relevant_majors = Array[]

    self.requirements.each do |requirement|
      relevant_majors.push(requirement.major)
    end

    return relevant_majors
  end

  # Get a comma-separated string of all relevant majors
  def all_majors_as_string

    # Get all relevant majors, pluck only their titles
    relevant_majors = self.all_majors.pluck(:title)

    # Return as joined-by-commas string
    return relevant_majors.join(", ")
  end

end
