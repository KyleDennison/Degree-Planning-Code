class Major < ApplicationRecord

  has_many :requirements
  has_many :courses, through: :requirements

  validates :title, presence: :true

end
