# TODO: Define your View class here, to display elements to the user and ask them for their input
require_relative 'controller'
require_relative 'recipe'

class View
  def display_list(recipes)
    recipes.each_with_index do |recipe, index|
      status = recipe.done? ? "[X]" : "[ ]"
      puts "#{index + 1} #{status} #{recipe.name}: #{recipe.description}"
      puts "#{recipe.rating}/5 - #{recipe.prep_time}"
    end
  end

  def display_recipe_name(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name}"
    end
  end

  def ask_user_for_recipe
    puts "Whats the recipe name?"
    recipe_name = gets.chomp
    puts "Whats the description?"
    recipe_description = gets.chomp
    { name: recipe_name, description: recipe_description }
  end

  def ask_user_for_number
    puts "Whats the recipe number?"
    return gets.chomp.to_i - 1
  end

  def ask_user_recipe_from_web
    puts "-" * 40
    puts "What ingredient would you like a recipe for?"
    recipe_ingredient = gets.chomp.downcase
    puts "Looking for #{recipe_ingredient} recipes on the Internet..."
    return recipe_ingredient
  end

  def display_recipes_from_web(recipes_web)
    puts "\n"
    puts "-" * 40
    recipes_web.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name}, #{recipe.rating}/5, #{recipe.prep_time}"
    end
    puts "-" * 40
    puts "\n"
  end

  def ask_to_import
    puts "Which recipe would you like to import? (enter index)"
    return gets.chomp.to_i - 1
  end
end
