class Requirement < ApplicationRecord

  belongs_to :major
  has_many :course_requirements
  has_many :courses, through: :course_requirements

  # Require a name for the requirement area
  validates :name, presence: true
  validates :major_id, presence: true

  # Require a specified minimum number of requirements
  # Can only be an integer, must be greater than or equal to 1
  validates :num_required, presence: true, numericality: {
      only_integer: true, greater_than_or_equal_to: 1
  }
end
