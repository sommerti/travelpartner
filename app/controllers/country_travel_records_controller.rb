class CountryTravelRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_country, except: [:destroy]
  before_action :set_travel_status, except: [:destroy]

  def create_update
    # user might want to update a record or try to add the same country again 
    # so start by searching for an existing country travel record matching the user and the country
    country_travel_record_id = current_user.find_country_travel_record(@country)

    # if such a record does not yet exist, create new record
    if country_travel_record_id.nil?

      @country_travel_record = CountryTravelRecord.new
      @country_travel_record.user_id = current_user.id
      @country_travel_record.country_id = @country.id
      @country_travel_record.travel_status = @travel_status

      if @country_travel_record.save 
        flash[:notice] = "You've marked '#{@country.country_name}' as 'wanna visit'." if @travel_status == "wannavisit"
        flash[:notice] = "You've marked '#{@country.country_name}' as 'have been'." if @travel_status == "havebeen"
      else
        flash[:alert] = "Country not added."
      end

    # if such a record is found, update the record
    else

      @country_travel_record = CountryTravelRecord.find(country_travel_record_id)
      @country_travel_record.travel_status = @travel_status

      if @country_travel_record.save 
        flash[:notice] = "You've updated '#{@country.country_name}' as 'wanna visit'." if @travel_status == "wannavisit"
        flash[:notice] = "You've updated '#{@country.country_name}' as 'have been'." if @travel_status == "havebeen"
      else
        flash[:alert] = "Country not added."
      end

    end

    redirect_to travel_records_user_path(current_user)

  end

  def destroy
    @country_travel_record = CountryTravelRecord.find(params[:id])
    @country_name = @country_travel_record.country.country_name
    @country_travel_record.destroy
    flash[:notice] = "'#{@country_name}' has been removed."

    redirect_to travel_records_user_path(current_user)
  end

  private
  
  def country_travel_record_params
    params.permit(:id, :country_id, :travel_status)
  end

  def set_country
    @country = Country.find(params[:country_id])
  end

  def set_travel_status
    @travel_status = params[:travel_status]
    # a user might tamper with travel status input        
    # if a user tries to set travel_status to anything other than "wannavisit" or "havebeen", set it to "wannavisit"
    if !(@travel_status == "wannavisit" or @travel_status == "havebeen")
      @travel_status == "wannavisit"
    end
  end

end
