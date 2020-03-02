class CompletedCoursePolicy < ApplicationPolicy


  def new?
    if user.faculty?
      false
    else
      true
    end
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def create?
    if user.faculty?
      @error_message = "You must be a student to completed a course."
      return false
    else
      return true
    end
  end

  def destroy?
    new?
  end

  def show?
    new?
  end
end