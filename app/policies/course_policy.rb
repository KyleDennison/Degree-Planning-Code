class CoursePolicy < ApplicationPolicy

  # Students can ONLY be able to view (show) courses.
  # Faculty can create and edit/update courses.
  # Administrators can destroy courses.

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
      @error_message = "You must be a faculty member to modify courses."
      return false
    else
      return true
    end
  end

  def destroy?
    @error_message = "Courses cannot currently be deleted."
    return false
  end
end