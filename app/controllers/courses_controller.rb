class CoursesController < ApplicationController

  # Require a logged-in user
  before_action :authenticate_user!

  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new

    # TODO: Need to switch from gem 'ancestry' to 'acts_as_tree'
    # There is an issue in which you can't declare children (in ancestry) when the
    # model has not yet been saved. With acts_as_tree, this shouldn't be a problem.
    # The workaround is to only allow a prereq (children) to be declared when editing
    # an already existing course (model).

    @course = Course.new

    authorize @course
  end

  # GET /courses/1/edit
  def edit
    authorize @course
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new
    @course.title = course_params[:title]
    @course.description = course_params[:description]

    requirement_area = Requirement.find(course_params[:requirement])
    if course_params[:requirement] != nil
      @course.requirements << requirement_area
    end

    authorize @course

    respond_to do |format|
      # First, see if course already exists when adding to requirement area
      does_course_exist = Course.where(title: course_params[:title]).first
      if course_params[:requirement] != nil && does_course_exist != nil
        # Course already exists!

        # Check to see if course is already in requirement area
        if requirement_area.courses.where(title: does_course_exist.title).empty?

          # Course doesn't exist in requirement area, let's add it!
          requirement_area.courses << does_course_exist

          format.html { redirect_to requirement_area, notice: 'Course already exists, but we added it to the requirement area.' }

        else

          # Course already exists in requirement area

          format.html { redirect_to requirement_area, notice: 'Course already exists AND is already in requirement area.' }
        end
      end

      if @course.save
        format.html { redirect_to requirement_area, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    authorize @course

    respond_to do |format|
      if @course.update(title: course_params[:title], description: course_params[:description])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    authorize @course

    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # TODO: Custom params whether creating or editing
    # E.g.
    def course_params
      # Permit params title, description, requirements, requirement (for specified requirement area id)
      params.require(:course).permit(:title, :description, :requirements, :requirement)
    end
end
