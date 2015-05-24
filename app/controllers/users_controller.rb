class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_user, only: [:show, :edit, :update, :travel_profile, :match, :big_map]
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

    @hash_country_travel_records = Gmaps4rails.build_markers(@user.country_travel_records) do |record, marker|
      marker.lat record.country.latitude
      marker.lng record.country.longitude

      if record.travel_status == "wannavisit"
        marker.picture({
          url: "https://cdn0.iconfinder.com/data/icons/small-n-flat/24/678087-heart-20.png",
          width: 32,
          height: 32
        })
      else
        marker.picture({       
          url: "https://cdn0.iconfinder.com/data/icons/small-n-flat/24/678134-sign-check-20.png",
          width: 32,
          height: 32
        })
      end
      
      marker.infowindow "<div style='width:200px;height:100%;'>#{record.country.country_name}</div>"
    end


  end

  def match
    @array_country_travel_records_both_wannavisit = 
      current_user.country_travel_records_wannavisit.pluck("country_id") & 
      @user.country_travel_records_wannavisit.pluck("country_id")
    
    @array_country_travel_records_i_wannavisit_friend_havebeen = 
      current_user.country_travel_records_wannavisit.pluck("country_id") &
      @user.country_travel_records_havebeen.pluck("country_id")
    
    @array_country_travel_records_i_havebeen_friend_wannavisit = 
      current_user.country_travel_records_havebeen.pluck("country_id") &  
      @user.country_travel_records_wannavisit.pluck("country_id")


    @travel_match_score = (@array_country_travel_records_both_wannavisit.size.to_f / 
                            current_user.country_travel_records_wannavisit.size * 100).round(2)
  
  end

  def big_map
    @hash_country_travel_records_big_map = Gmaps4rails.build_markers(@user.country_travel_records) do |record, marker|
      marker.lat record.country.latitude
      marker.lng record.country.longitude

      if record.travel_status == "wannavisit"
        marker.picture({
          url: "https://cdn0.iconfinder.com/data/icons/small-n-flat/24/678087-heart-20.png",
          width: 32,
          height: 32
        })
      else
        marker.picture({       
          url: "https://cdn0.iconfinder.com/data/icons/small-n-flat/24/678134-sign-check-20.png",
          width: 32,
          height: 32
        })
      end
      
      marker.infowindow "<div style='width:200px;height:100%;'>#{record.country.country_name}</div>"
      end
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
