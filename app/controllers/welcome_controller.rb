class WelcomeController < ApplicationController
  
  def index
  end

  def how_it_works
  end

  def wiki
  	@country = Country.find(params[:country_id])
  	@response = HTTParty.get("http://wikitravel.org/wiki/en/api.php?
  							action=query&prop=extracts&format=json&
  							titles=#{@country.country_name}")
  end
end
