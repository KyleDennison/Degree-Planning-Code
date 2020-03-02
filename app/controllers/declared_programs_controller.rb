class DeclaredProgramsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_declared_program, only: [:show, :edit, :update, :destroy]

  # GET /declared_programs
  # GET /declared_programs.json
  def index
    @declared_programs = DeclaredProgram.all
    authorize @declared_programs
  end

  # GET /declared_programs/1
  # GET /declared_programs/1.json
  def show
    authorize @declared_program
  end

  # GET /declared_programs/new
  def new
    @declared_program = DeclaredProgram.new
    @declared_program.user = current_user

    authorize @declared_program
  end

  # GET /declared_programs/1/edit
  def edit
    authorize @declared_program
  end

  # POST /declared_programs
  # POST /declared_programs.json
  def create
    @declared_program = DeclaredProgram.new(declared_program_params)

    respond_to do |format|
      if @declared_program.save
        format.html { redirect_to @declared_program, notice: 'You successfully declared an academic program.' }
        format.json { render :show, status: :created, location: @declared_program }
      else
        format.html { render :new }
        format.json { render json: @declared_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /declared_programs/1
  # PATCH/PUT /declared_programs/1.json
  def update
    respond_to do |format|
      if @declared_program.update(declared_program_params)
        format.html { redirect_to @declared_program, notice: 'You successfully updated your declared academic program.' }
        format.json { render :show, status: :ok, location: @declared_program }
      else
        format.html { render :edit }
        format.json { render json: @declared_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /declared_programs/1
  # DELETE /declared_programs/1.json
  def destroy
    authorize @declared_program

    @declared_program.destroy
    respond_to do |format|
      format.html { redirect_to declared_programs_url, notice: 'Declared program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_declared_program
      @declared_program = DeclaredProgram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def declared_program_params
      params.require(:declared_program).permit(:user_id, :major_id)
    end
end
