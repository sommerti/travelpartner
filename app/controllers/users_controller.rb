class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_user, only: [:show, :edit, :update]
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

  private
  
  def user_params
    params.require(:user).permit(:firstname, :lastname, :about, :country, :city, :age, :gender, :avatar, :delete_avatar)
  end

  def set_user   
    @user = User.friendly.find(params[:id])
  end
  
  def format_params
    @formatted_params = user_params
    
    # if capitalizing every word
    @formatted_params[:firstname] = capitalize_input(@formatted_params[:firstname])
    @formatted_params[:lastname] = capitalize_input(@formatted_params[:lastname])
    @formatted_params[:country] = capitalize_input(@formatted_params[:country])
    @formatted_params[:city] = capitalize_input(@formatted_params[:city])

    # if using auto_html gem
    # @formatted_params[:about] = auto_html(@formatted_params[:about]){ simple_format; link(target: 'blank') }
    # @formatted_params[:about] = @formatted_params[:about][3..(@formatted_params[:about].length-5)] if !@formatted_params[:about].empty?
  end
end
