class CategoriesController < ApplicationController
  include DeleteConcern
  include LoadRecordConcern

  # GET /categories or /categories.json
  def index
    @categories = Category.all.to_a.sort_by(&:name)
    count_recipes_by_ids = Category.count_recipes_by_ids(@categories.map(&:id))
    @categories.each do |category|
      category.recipes_count = count_recipes_by_ids[category.id]
    end
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  # used at controller/concerns/delete_concern.rb  

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def category_params
      params.expect(category: [ :name, :summary ])
    end
end
