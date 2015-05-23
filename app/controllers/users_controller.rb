class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_user, only: [:show, :edit, :update, :travel_profile]
  before_action :format_params, only: [:update]

  def show
  end

  def edit
  end

  def update
    @user.slug = nil
    if @user.update(@formatted_params)
        
        # check if user wants to delete avatar  
        if @formatted_params[:delete_avatar] == "true"
          @user.avatar = nil
          @user.save
        end
      
      flash[:notice] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def travel_profile
    @countries = Country.all
    @countries_in_asia = Country.in_asia
    @countries_in_europe = Country.in_europe
    @countries_in_northamerica = Country.in_northamerica
    @countries_in_southamerica = Country.in_southamerica
    @countries_in_africa = Country.in_africa
    @countries_in_oceania = Country.in_oceania
    @countries_in_antarctica = Country.in_antarctica
  end




  private
  
  def user_params
    params.require(:user).permit(:firstname, :lastname, :about, :country, :city, :age, :gender, :avatar, :delete_avatar)
  end

  def set_user   
    @user = User.friendly.find(params[:id])
  end
  
  def format_params
    @formatted_params = user_params
    
    # if capitalizing names and cities
    @formatted_params[:firstname] = capitalize_input(@formatted_params[:firstname])
    @formatted_params[:lastname] = capitalize_input(@formatted_params[:lastname])
    @formatted_params[:city] = capitalize_input(@formatted_params[:city])

    # if using gem auto_html
    # @formatted_params[:about] = auto_html(@formatted_params[:about]){ simple_format; link(target: 'blank') }
    # @formatted_params[:about] = @formatted_params[:about][3..(@formatted_params[:about].length-5)] if !@formatted_params[:about].empty?
  end
end
