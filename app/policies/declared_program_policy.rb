class DeclaredProgramPolicy < ApplicationPolicy

  # Declaring a new academic program
  # Make sure the student doesn't already have a declared program
  def new?
    if @user.declared_programs.first
      @error_message = "You have already declared an academic program."
      return false
    else
      return true
    end
  end

  def edit?
    if @record.user_id == @user.id
      return true
    else
      return false
    end
  end

  # Only let faculty or the logged-in student see a declared program record
  def show?
    if (@record.user_id == @user.id) || user.faculty?
      return true
    else
      return false
    end
  end

  # Only let administrators to completely delete declared program records
  def destroy?
    return false
  end

  def index?
    if user.faculty?
      return true
    else
      @error_message = "Only faculty members can see all completed courses."
      return false
    end
  end

end