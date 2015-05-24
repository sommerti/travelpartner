class CountriesController < ApplicationController
  def index
  	@countries = Country.all  	
  end

  def update
  	@country = Country.find(params[:id])
  	if @country.update(country_params)
  	    flash[:notice] = "Updated"
    else
		flash[:notice] = "Update failed."
	end
    
    redirect_to countries_path
  end

  private
  def country_params
    params.permit(:id)
  end
end
