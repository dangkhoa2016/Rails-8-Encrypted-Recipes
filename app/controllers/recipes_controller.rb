class RecipesController < ApplicationController
  include DeleteConcern
  include LoadRecordConcern
  before_action :set_ingredient, only: [:add_ingredient, :create_ingredient]
  before_action :set_step, only: [:add_step, :create_step]

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
        update_tags
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
        update_tags
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  # used at controller/concerns/delete_concern.rb

  def add_ingredient
    render partial: 'recipes/ingredient_form', locals: { ingredient_recipe: @ingredient_recipe }
  end

  def create_ingredient
    if @ingredient_recipe.save
      respond_to do |format|
        format.html { redirect_to @recipe, notice: "Ingredient was successfully added." }
        format.json { render :show, status: :created, location: @recipe }
        format.turbo_stream do
          is_from_ingredient_recipes_page = params[:ingredient_recipes_page].present?
          render turbo_stream: [
            turbo_stream.update("recipe-#{@recipe.id}-ingredients",
              partial: is_from_ingredient_recipes_page ? "ingredient_recipes/ingredient_list" : "recipes/ingredient_list",
              locals: { ingredient_recipes: @recipe.preload_ingredient_recipes }),
            turbo_stream.append(@recipe, '<script>closeModal()</script>')
          ]
        end
      end
    else
      add_ingredient
    end
  end

  def add_step
    render partial: 'recipes/step_form', locals: { step: @step }
  end

  def create_step
    if @step.save
      respond_to do |format|
        format.html { redirect_to @recipe, notice: "Step was successfully added." }
        format.json { render :show, status: :created, location: @recipe }
        format.turbo_stream do
          is_from_steps_page = params[:steps_page].present?
          render turbo_stream: [
            turbo_stream.update("recipe-#{@recipe.id}-steps",
              partial: is_from_steps_page ? "steps/step_list" : "recipes/step_list",
              locals: { steps: @recipe.steps }),
            turbo_stream.append(@recipe, '<script>closeModal()</script>')
          ]
        end
      end
    else
      add_step
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.expect(recipe: [ :name, :summary, :cuisine_type, :is_vegetarian,
        :calories, :prepare_duration, :category_id ])
    end

    def update_tags
      old_tags = @recipe.tags.pluck(:id)
      new_tags = params[:tag_ids].map(&:to_i)
      recipe_tags = RecipeTag.where(recipe_id: @recipe.id)
      if new_tags.size >= old_tags.size
        new_tags.each_with_index do |tag_id, index|
          if index < old_tags.size
            recipe_tags[index].update(tag_id: tag_id)
          else
            RecipeTag.create(recipe_id: @recipe.id, tag_id: tag_id)
          end
        end
      else
        remove_tag_count = old_tags.size - new_tags.size
        recipe_tags.last(remove_tag_count).each(&:destroy)
        recipe_tags.each_with_index do |recipe_tag, index|
          recipe_tag.update(tag_id: new_tags[index])
        end
      end
    end

    def ingredient_recipe_params
      params.require(:ingredient_recipe).permit(:ingredient_id, :amount, :unit) if action_name == 'create_ingredient'
    end

    def additional_actions_for_load_record
      [:add_ingredient, :create_ingredient, :add_step, :create_step]
    end

    def set_ingredient
      @ingredient_recipe = IngredientRecipe.new(ingredient_recipe_params)
      @ingredient_recipe.recipe = @recipe
    end
    
    def step_params
      params.require(:step).permit( :name, :step_number, :description) if action_name == 'create_step'
    end

    def set_step
      @step = Step.new(step_params)
      @step.step_number = @recipe.steps.size + 1
      @step.recipe = @recipe
    end
end
