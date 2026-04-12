class IngredientsController < ApplicationController
  include DeleteConcern
  include TagUpdater
  include LoadRecordConcern

  # GET /ingredients or /ingredients.json
  def index
    @ingredients = Ingredient.all.to_a.sort_by(&:name)
    ids = @ingredients.pluck(:id)
    ingredient_recipes = IngredientRecipe.where(ingredient_id: ids).to_a
    recipes = Recipe.where(id: ingredient_recipes.pluck(:recipe_id).uniq).to_a
    ingredient_tags = IngredientTag.where(ingredient_id: ids).to_a
    tags = Tag.where(id: ingredient_tags.pluck(:tag_id).uniq).to_a
    @ingredients.each do |ingredient|
      relation = ingredient_recipes.select { |ingredient_recipe| ingredient_recipe.ingredient_id == ingredient.id }
      ingredient.virtual_recipes = recipes.select { |recipe| relation.any? { |ingredient_recipe| ingredient_recipe.recipe_id == recipe.id } }.sort_by(&:name)
      relation = ingredient_tags.select { |ingredient_tag| ingredient_tag.ingredient_id == ingredient.id }
      ingredient.virtual_tags = tags.select { |tag| relation.any? { |ingredient_tag| ingredient_tag.tag_id == tag.id } }.sort_by(&:name)
    end
  end

  # GET /ingredients/1 or /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
  end

  # POST /ingredients or /ingredients.json
  def create
    @ingredient = Ingredient.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        update_tags(@ingredient, IngredientTag)
        format.html { redirect_to @ingredient, notice: "Ingredient was successfully created." }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients/1 or /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        update_tags(@ingredient, IngredientTag)
        format.html { redirect_to @ingredient, notice: "Ingredient was successfully updated." }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1 or /ingredients/1.json
  # used at controller/concerns/delete_concern.rb

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def ingredient_params
      params.expect(ingredient: [ :name, :description ])
    end
end
