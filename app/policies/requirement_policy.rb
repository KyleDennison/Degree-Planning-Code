class RequirementPolicy < ApplicationPolicy

  # Students can ONLY be able to view (show) requirements.
  # Faculty can create and edit/update requirements.
  # Administrators can destroy requirements.

  def new?
    create?
  end

  def edit?
    create?
  end

  def update?
    create?
  end

  def create?
    if user.faculty? == false
      @error_message = "You must be a faculty member to modify requirements."
      return false
    else
      return true
    end
  end

  def destroy?
    @error_message = "Courses cannot currently be deleted."
    return false
  end

  def index?
    return false
  end
end