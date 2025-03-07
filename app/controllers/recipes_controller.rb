class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]
  include TagUpdater

  # GET /recipes or /recipes.json
  def index
    category_id = params[:category]
    query = Recipe.all
    if category_id.present?
      @category = Category.find_by(id: category_id)
      query = query.where(category_id: category_id)
    else
      query = query.includes(:category)
    end

    @recipes = query.to_a.sort_by(&:name)
    count_steps_by_ids = Recipe.count_steps_by_ids(@recipes.map(&:id))
    count_ingredients_by_ids = Recipe.count_ingredients_by_ids(@recipes.map(&:id))
    @recipes.each do |recipe|
      recipe.steps_count = count_steps_by_ids[recipe.id]
      recipe.ingredients_count = count_ingredients_by_ids[recipe.id]
    end
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        update_tags(@recipe, RecipeTag)
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        update_tags(@recipe, RecipeTag)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_path, status: :see_other, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.expect(recipe: [ :name, :summary, :cuisine_type, :is_vegetarian,
        :calories, :prepare_duration, :category_id ])
    end
end
