class RequirementsController < ApplicationController

  # Require user to be logged in
  before_action :authenticate_user!

  before_action :set_requirement, only: [:show, :edit, :update, :destroy]

  # GET /requirements
  # GET /requirements.json
  def index
    @requirements = Requirement.all
    authorize @requirements
  end

  # GET /requirements/1
  # GET /requirements/1.json
  def show
  end

  # GET /requirements/new
  def new
    @requirement = Requirement.new

    authorize @requirement
  end

  # GET /requirements/1/edit
  def edit
    authorize @requirement
  end

  # POST /requirements
  # POST /requirements.json
  def create
    puts "requirement_params: #{requirement_params}"
    @requirement = Requirement.new
    @requirement.name = requirement_params[:name]
    @requirement.description = requirement_params[:description]
    @requirement.num_required = requirement_params[:num_required]

    if !requirement_params[:major].empty?
      @requirement.major = Major.find(requirement_params[:major])
    end

    authorize @requirement

    respond_to do |format|
      if @requirement.save
        #format.html { redirect_to @requirement, notice: 'Requirement was successfully created.' }
        format.html { redirect_to major_path(@requirement.major), notice: "Requirement area successfully added."}
        format.json { render :show, status: :created, location: @requirement }
      else
        format.html { render :new, locals: { major: params[:major] } }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requirements/1
  # PATCH/PUT /requirements/1.json
  def update
    authorize @requirement

    respond_to do |format|
      if @requirement.update(
                         name: requirement_params[:name],
                         description: requirement_params[:description],
                         num_required: requirement_params[:num_required]
      )
        format.html { redirect_to @requirement, notice: 'Requirement was successfully updated.' }
        format.json { render :show, status: :ok, location: @requirement }
      else
        format.html { render :edit }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requirements/1
  # DELETE /requirements/1.json
  def destroy
    authorize @requirement

    @requirement.destroy
    respond_to do |format|
      format.html { redirect_to requirements_url, notice: 'Requirement area was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requirement
      @requirement = Requirement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requirement_params

      # Permit params for name and specified major_id
      #params.permit(:requirement, :name, :major)
      # Always require a major to add the requirement area to
      params.require(:requirement).permit(:name, :major, :description, :num_required)
    end
end
