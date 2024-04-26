class Recipe
  attr_reader :name, :description, :rating, :prep_time, :done

  # def initialize(name, description, rating = nil)
  #   @name = name
  #   @description = description
  #   @rating = rating
  # end

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end

  # def to_s
  #   "Recipe: #{@name}\nDescription: #{@description}\nRating: #{@rating || 'Not rated'}"
  # end
end
