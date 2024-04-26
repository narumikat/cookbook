# TODO: Implement the Cookbook class that will be our repository
require 'csv'
require_relative 'recipe'

class Cookbook
  attr_accessor :recipes

  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    load_csv
  end

  def create(recipe)
    @recipes << recipe
    save_csv
  end

  def all
    @recipes
  end

  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def mark_recipe_as_done(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    save_to_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: true) do |row|
      # recipe_name = row["name"]
      # recipe_description = row["description"]
      # recipe = Recipe.new(recipe_name, recipe_description)
      # @recipes << recipe
      row[:done] = row[:done] == "true"
      @recipes << Recipe.new(row)
    end
  end

  def save_to_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << ["name", "description", "rating", "prep_time", "done"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end
