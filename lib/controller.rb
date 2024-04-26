#  TODO: Define your Controller Class here, to orchestrate the other classes
require_relative 'cookbook'
require_relative 'view'
require_relative 'scrap'

class Controller
  attr_reader :cookbook, :view

  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
    @scrap = Scrap.new
  end

  def list
    @view.display_list(@cookbook.all)
  end

  def list_names
    @view.display_recipe_name(@cookbook.all)
  end

  def add
    new_recipe = @view.ask_user_for_recipe
    recipe = Recipe.new(new_recipe[:name], new_recipe[:description], new_recipe[:rating], new_recipe[:prep_time])
    @cookbook.create(recipe)
  end

  def remove
    display_recipes
    index = @view.ask_user_for_number
    @cookbook.destroy(index)
  end

  def import
    recipe_web = @view.ask_user_recipe_from_web
    results = @scrap.search_on_web(recipe_web)
    @view.display_recipes_from_web(results)
    index = @view.ask_to_import
    @cookbook.create(results[index])
    puts "\n"
    list_names
  end

  def mark_as_done
    list
    index = @view.ask_user_for_number
    # 3. Mark as done and save (repo)
    @cookbook.mark_recipe_as_done(index)
    # 4. Display recipes
    display_recipes
  end

  private

  def display_recipes
    recipes = @cookbook.all
    @view.display_list(recipes)
  end
end
