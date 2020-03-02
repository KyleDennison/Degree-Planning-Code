class DeclaredProgram < ApplicationRecord
  belongs_to :user
  belongs_to :major

  validates :user_id, presence: true
  validates :major_id, presence: true
end
