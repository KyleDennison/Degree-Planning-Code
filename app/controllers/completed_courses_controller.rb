class CompletedCoursesController < ApplicationController

  # Require user to be logged in
  before_action :authenticate_user!

  before_action :set_completed_course, only: [:show, :edit, :update, :destroy]

  # GET /completed_courses
  # GET /completed_courses.json
  def index
    if current_user.faculty?
      # Return all completed_courses ordered by :course_id
      @completed_courses = CompletedCourse.all.order(:course_id)
    else
      @completed_courses = CompletedCourse.where(user_id: current_user)
    end
  end

  # GET /completed_courses/1
  # GET /completed_courses/1.json
  def show
    authorize @completed_course
  end

  # GET /completed_courses/new
  def new
    @completed_course = CompletedCourse.new
    authorize @completed_course
  end

  # GET /completed_courses/1/edit
  def edit
    authorize @completed_course
  end

  # POST /completed_courses
  # POST /completed_courses.json
  def create
    @completed_course = CompletedCourse.new(completed_course_params)

    respond_to do |format|
      if CompletedCourse.where(user_id: current_user, course_id: @completed_course.course_id).size != 0
        format.html {redirect_to @completed_course, alert: 'Course already completed.'}
        format.json {render :show, status: :ok, location: @completed_course}
      elsif @completed_course.save

        # Redirect to the user's declared program if one exists
        if current_user.declared_programs.first
          format.html { redirect_to major_path(current_user.declared_programs.first.major_id), notice: 'Course was marked as complete.' }
        else

          # Else, go to their completed courses list
          format.html {redirect_to completed_courses_path, notice: 'Course was marked as complete.'}
        end

        # JSON stuff
        format.json {render :show, status: :created, location: @completed_course}
      else
        format.html {render :new}
        format.json {render json: @completed_course.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /completed_courses/1
  # PATCH/PUT /completed_courses/1.json
  def update
    respond_to do |format|
      if @completed_course.update(completed_course_params)
        format.html {redirect_to @completed_course, notice: 'Completed course was successfully updated.'}
        format.json {render :show, status: :ok, location: @completed_course}
      else
        format.html {render :edit}
        format.json {render json: @completed_course.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /completed_courses/1
  # DELETE /completed_courses/1.json
  def destroy
    authorize @completed_course
    @completed_course.destroy
    respond_to do |format|
      format.html {redirect_to completed_courses_url, notice: 'Completed course was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def set_completed_course
    @completed_course = CompletedCourse.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def completed_course_params
    params.require(:completed_course).permit(:user_id, :course_id)
  end
end
