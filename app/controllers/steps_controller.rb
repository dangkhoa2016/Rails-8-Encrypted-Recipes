class StepsController < ApplicationController
  include DeleteConcern
  include LoadRecordConcern

  # GET /steps or /steps.json
  def index
    @recipes = Recipe.includes(:steps).sort_by(&:name)
  end

  # GET /steps/1 or /steps/1.json
  def show
  end

  # GET /steps/new
  def new
    @step = Step.new(step_number: 1)
    if params[:recipe_id].present?
      @step.recipe_id = params[:recipe_id]
    end
  end

  # GET /steps/1/edit
  def edit
  end

  # POST /steps or /steps.json
  def create
    @step = Step.new(step_params)

    respond_to do |format|
      if @step.save
        format.html { redirect_to @step, notice: "Step was successfully created." }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1 or /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to @step, notice: "Step was successfully updated." }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1 or /steps/1.json
  # used at controller/concerns/delete_concern.rb

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def step_params
      params.expect(step: [ :name, :step_number, :description, :recipe_id ])
    end
end
