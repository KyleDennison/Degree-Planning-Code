class MajorPolicy < ApplicationPolicy

  # Students should only be able to VIEW (show) an academic program.
  # Faculty can create and edit/update academic programs.
  # Administrators can destroy academic programs.

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
    if !user.faculty?
      @error_message = "You must be a faculty member to modify academic programs."
      return false
    else
      return true
    end
  end

  def destroy?
    @error_message = "Academic programs cannot currently be deleted."
    return false
  end

end