# rubocop:disable Metrics/MethodLength
require "open-uri"
require "nokogiri"
require_relative 'controller'
require_relative "recipe"

class Scrap
  def search_on_web(ingredient)
    html = URI.open("https://www.allrecipes.com/search?q=#{ingredient}").read
    doc = Nokogiri::HTML.parse(html, nil, "utf-8")
    results = []

    doc.search("a.mntl-card-list-items").each do |element|
      name = element.search(".card__title-text").text.strip
      details_url = element['href']

      # Acessando a URL de detalhes
      details_html = URI.open(details_url).read
      rating = element.search(".icon.icon-star").count + (element.search(".icon.icon-star-half").count * 0.5)
      details_doc = Nokogiri::HTML.parse(details_html, nil, "utf-8")

      # Verifica se há descrição dentro de elementos com classe '.comp.mntl-sc-block.mntl-sc-block-html'
      description_elements = details_doc.search(".comp.mntl-sc-block.mntl-sc-block-html")
      description = description_elements.map { |elem| elem.text.strip }.join("\n")

      prep_time = "no time provided"
      details_doc.search(".mntl-recipe-details__item").each do |prep_details|
        if prep_details.search('.mntl-recipe-details__label:contains("Prep Time:")').any?
          prep_time = prep_details.search(".mntl-recipe-details__value").text.strip
        end
      end

      # Adiciona a receita à lista de resultados
      results << Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time)
    end

    results.first(5)
  end
end
# rubocop:enable Metrics/MethodLength

# recipes_scrap = Scrap.new
# recipes = recipes_scrap.search_on_web('strawberry')
# puts recipes
