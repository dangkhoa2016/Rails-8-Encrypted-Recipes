class HomeController < ApplicationController
  def index
  end

  def top_widgets
    respond_to do |format|
      format.json do
        render json: {
          categories: Category.count,
          recipes: Recipe.count,
          ingredients: Ingredient.count,
          tags: Tag.count
        }
      end

      format.html do
        render_turbo_stream_top_widgets
      end

      format.turbo_stream do
        render_turbo_stream_top_widgets
      end
    end
  end

  def latest_recipes
    data = Recipe.includes(:steps).order("created_at DESC").limit(5)
    respond_to do |format|
      format.json do
        render json: data
      end

      format.html do
        render_turbo_stream_latest_recipes(data)
      end

      format.turbo_stream do
        render_turbo_stream_latest_recipes(data)
      end
    end
  end

  def ingredient_tags
    data = Tag.ingredient_tags_with_count

    respond_to do |format|
      format.json do
        render json: data
      end

      format.html do
        render_turbo_stream_tags_list(data, "ingredient")
      end

      format.turbo_stream do
        render_turbo_stream_tags_list(data, "ingredient")
      end
    end
  end

  def recipe_tags
    data = Tag.recipe_tags_with_count

    respond_to do |format|
      format.json do
        render json: data
      end

      format.html do
        render_turbo_stream_tags_list(data, "recipe")
      end

      format.turbo_stream do
        render_turbo_stream_tags_list(data, "recipe")
      end
    end
  end

  def top_cuisines
    arr = Recipe.where.not(cuisine_type: nil).group(:cuisine_type).count.sort_by { |_k, v| v }.reverse
    data = arr.map { |k, v| { name: k.titleize, count: v, slug: k } }

    respond_to do |format|
      format.json do
        render json: data
      end

      format.html do
        render_turbo_stream_top_cuisines(data)
      end

      format.turbo_stream do
        render_turbo_stream_top_cuisines(data)
      end
    end
  end

  private

  def render_turbo_stream_top_widgets
    response.content_type = "text/vnd.turbo-stream.html"
    render turbo_stream: [
      turbo_stream.update("categories-count", body: Category.count),
      turbo_stream.update("recipes-count", body: Recipe.count),
      turbo_stream.update("ingredients-count", body: Ingredient.count),
      turbo_stream.update("tags-count", body: Tag.count)
    ],
    status: :ok,
    layout: false
  end

  def render_turbo_stream_latest_recipes(data)
    response.content_type = "text/vnd.turbo-stream.html"
    render turbo_stream: (
      turbo_stream.update("latest-recipes", partial: "home/latest_recipes",
        locals: { recipes: data })
    ),
    status: :ok,
    layout: false
  end

  def render_turbo_stream_tags_list(data, association = "recipe")
    response.content_type = "text/vnd.turbo-stream.html"
    render turbo_stream: (
      turbo_stream.update("#{association}-tags-list", partial: "home/tags_list",
        locals: { tags: data, association: association })
    ),
    status: :ok,
    layout: false
  end

  def render_turbo_stream_top_cuisines(data)
    response.content_type = "text/vnd.turbo-stream.html"
    render turbo_stream: (
      turbo_stream.update("top-cuisines-list", partial: "home/top_cuisines",
        locals: { cuisines: data })
    ),
    status: :ok,
    layout: false
  end
end
