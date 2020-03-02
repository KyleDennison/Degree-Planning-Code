class UserController < ApplicationController

  # Require a logged-in user
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])

    # Get the declared program
    @declared_program = nil
    @courses_left = nil

    if @user.declared_programs.first
      @declared_program = @user.declared_programs.first.major

      # Track degree progress

      # Courses completed by user
      @completed_courses = @user.completed_courses

      # Courses still needed for major
      @requirements_left = []

      # Courses belonging to major
      @major_courses = []

      for req in Requirement.where(major_id: @declared_program.id)
        @course_reqs = CourseRequirement.where(requirement_id: req.id)

        num_completed = 0

        for c_req in @course_reqs
          @req_course = Course.where(id: c_req.course_id).first

          for c_course in @completed_courses
            if c_course.course_id == @req_course.id
              num_completed += 1
            end
          end
        end

        if num_completed < req.num_required
          num_left = req.num_required - num_completed
          if num_left > 1
            @requirements_left.push(req.name + ": " +  num_left.to_s + " courses left")
          else
            @requirements_left.push(req.name + ": " +  num_left.to_s + " course left")
          end
        end
      end
    end

    # Make sure that user is viewing their own page
    if @user != current_user
      flash[:alert] = "You do not have permission to view this page."
      redirect_to(request.referrer || root_path)
    end
  end

end
