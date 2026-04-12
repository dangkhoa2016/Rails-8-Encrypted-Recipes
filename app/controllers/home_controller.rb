class HomeController < ApplicationController
  before_action :dashboard_service

  def index
  end

  def top_widgets
    data = @dashboard_service.top_widgets
    respond_to do |format|
      format.json { render json: data }
      format.html { render_turbo_stream_top_widgets(data) }
      format.turbo_stream { render_turbo_stream_top_widgets(data) }
    end
  end

  def latest_recipes
    data = @dashboard_service.latest_recipes
    respond_to do |format|
      format.json { render json: data }
      format.html { render_turbo_stream_latest_recipes(data) }
      format.turbo_stream { render_turbo_stream_latest_recipes(data) }
    end
  end

  def ingredient_tags
    data = @dashboard_service.ingredient_tags
    respond_to do |format|
      format.json { render json: data }
      format.html { render_turbo_stream_tags_list(data, "ingredient") }
      format.turbo_stream { render_turbo_stream_tags_list(data, "ingredient") }
    end
  end

  def recipe_tags
    data = @dashboard_service.recipe_tags
    respond_to do |format|
      format.json { render json: data }
      format.html { render_turbo_stream_tags_list(data, "recipe") }
      format.turbo_stream { render_turbo_stream_tags_list(data, "recipe") }
    end
  end

  def top_cuisines
    data = @dashboard_service.top_cuisines
    respond_to do |format|
      format.json { render json: data }
      format.html { render_turbo_stream_top_cuisines(data) }
      format.turbo_stream { render_turbo_stream_top_cuisines(data) }
    end
  end

  private

  def dashboard_service
    @dashboard_service ||= DashboardService.new
  end

  def render_turbo_stream_top_widgets(data)
    response.content_type = "text/vnd.turbo-stream.html"
    render turbo_stream: [
      turbo_stream.update("categories-count", body: data[:categories]),
      turbo_stream.update("recipes-count",     body: data[:recipes]),
      turbo_stream.update("ingredients-count", body: data[:ingredients]),
      turbo_stream.update("tags-count",        body: data[:tags])
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
