class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception


	def capitalize_input(input)
		input.downcase.split(' ').map(&:capitalize).join(' ')
	end
	
	def build_country_travel_records_hash(user)

		hash_country_travel_records = Gmaps4rails.build_markers(user.country_travel_records) do |record, marker|
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

		hash_country_travel_records
		
	end


end
