class CountryTravelRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_country
  before_action :set_user

  def create
    # a user might try to add the same country again 
    # so start by searching for an existing country travel record matching the user and the country
    country_travel_record_id = @user.find_country_travel_record(@country)

    # if such a record does not yet exist, create new record
    if country_travel_record_id.nil?
      @country_travel_record = CountryTravelRecord.new
      @country_travel_record.user_id = @user.id
      @country_travel_record.country_id = @country.id
      

      # a user might tamper with travel status input        
      # if a user tries to set travel_status to anything other than "wannavisit" or "havebeen", set it to "wannavisit"
      if country_travel_record_params[:travel_status] == "wannavisit" or country_travel_record_params[:travel_status] == "havebeen"
        @country_travel_record.travel_status = country_travel_record_params[:travel_status]
      else 
        @country_travel_record.travel_status = "wannavisit"
      end


      if @country_travel_record.save 
        if @country_travel_record.travel_status == "wannavisit"
          flash[:notice] = "You've marked #{@country.country_name} as 'wanna visit'."
        end
        if @country_travel_record.travel_status == "havebeen"
          flash[:notice] = "You've marked #{@country.country_name} as 'have been'."
        end
      else
        flash[:alert] = "Country not added."
      end


    # if sucha record is found, update the record
    else
      @country_travel_record = CountryTravelRecord.find(country_travel_record_id)
      

      # a user might tamper with travel status input        
      # if a user tries to set travel_status to anything other than "wannavisit" or "havebeen", set it to "wannavisit"
      if country_travel_record_params[:travel_status] == "wannavisit" or country_travel_record_params[:travel_status] == "havebeen"
        @country_travel_record.travel_status = country_travel_record_params[:travel_status]
      else 
        @country_travel_record.travel_status = "wannavisit"
      end


      if @country_travel_record.save 
        if @country_travel_record.travel_status == "wannavisit"
          flash[:notice] = "You've updated your travel record for #{@country.country_name} as 'wanna visit'."
        end
        if @country_travel_record.travel_status == "havebeen"
          flash[:notice] = "You've updated your travel record for #{@country.country_name} as 'have been'."
        end
      else
        flash[:alert] = "Country not updated."
      end
    end

    redirect_to travel_profile_user_path(@user)

  end

  def update
  end

  def destroy
  end

  private
  
  def country_travel_record_params
    params.permit(:id, :country_id, :travel_status)
  end

  def set_country
    @country = Country.find(params[:country_id])
  end

  def set_user   
    @user = User.friendly.find(params[:id])
  end

end
