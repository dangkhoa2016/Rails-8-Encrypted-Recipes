class TagsController < ApplicationController
  include DeleteConcern
  include LoadRecordConcern

  # GET /tags or /tags.json
  def index
    @tags = Tag.all.to_a.sort_by(&:name)
    ids = @tags.pluck(:id)
    ingredient_tags = IngredientTag.where(tag_id: ids).to_a
    ingredients = Ingredient.where(id: ingredient_tags.pluck(:ingredient_id).uniq)
    recipe_tags = RecipeTag.where(tag_id: ids).to_a
    recipes = Recipe.where(id: recipe_tags.pluck(:recipe_id).uniq)
    @tags.each do |tag|
      tag.virtual_recipes = recipes.select { |r| recipe_tags.any? { |rt| rt.recipe_id == r.id && rt.tag_id == tag.id } }
      tag.virtual_ingredients = ingredients.select { |i| ingredient_tags.any? { |it| it.ingredient_id == i.id && it.tag_id == tag.id } }
    end
  end

  # GET /tags/1 or /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags or /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: "Tag was successfully created." }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1 or /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: "Tag was successfully updated." }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1 or /tags/1.json
  # used at controller/concerns/delete_concern.rb  

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def tag_params
      params.expect(tag: [ :name, :tag_type ])
    end
end
