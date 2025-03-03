class IngredientRecipesController < ApplicationController
  before_action :set_ingredient_recipe, only: %i[ show edit update destroy ]

  # GET /ingredient_recipes or /ingredient_recipes.json
  def index
    @ingredient_recipes = IngredientRecipe.all
  end

  # GET /ingredient_recipes/1 or /ingredient_recipes/1.json
  def show
  end

  # GET /ingredient_recipes/new
  def new
    @ingredient_recipe = IngredientRecipe.new
  end

  # GET /ingredient_recipes/1/edit
  def edit
  end

  # POST /ingredient_recipes or /ingredient_recipes.json
  def create
    @ingredient_recipe = IngredientRecipe.new(ingredient_recipe_params)

    respond_to do |format|
      if @ingredient_recipe.save
        format.html { redirect_to @ingredient_recipe, notice: "Ingredient recipe was successfully created." }
        format.json { render :show, status: :created, location: @ingredient_recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ingredient_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredient_recipes/1 or /ingredient_recipes/1.json
  def update
    respond_to do |format|
      if @ingredient_recipe.update(ingredient_recipe_params)
        format.html { redirect_to @ingredient_recipe, notice: "Ingredient recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @ingredient_recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ingredient_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredient_recipes/1 or /ingredient_recipes/1.json
  def destroy
    @ingredient_recipe.destroy!

    respond_to do |format|
      format.html { redirect_to ingredient_recipes_path, status: :see_other, notice: "Ingredient recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient_recipe
      @ingredient_recipe = IngredientRecipe.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def ingredient_recipe_params
      params.expect(ingredient_recipe: [ :ingredient_id, :recipe_id, :amount, :unit ])
    end
end
