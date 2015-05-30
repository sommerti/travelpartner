# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  firstname              :string
#  lastname               :string
#  about                  :text
#  country                :string
#  city                   :string
#  age                    :integer
#  gender                 :string
#  role                   :string
#  slug                   :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  delete_avatar          :boolean
#

class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	has_many :country_travel_records

  	# gem paperclip	     
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, 
								default_url: ":style/default.gif"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  	# gem friendly_id
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	def slug_candidates
	[
	  [:firstname, :lastname],
	  [:firstname, :lastname, :country],
	  [:firstname, :lastname, :country, :city],
	]
	end

	# gem acts_as_follower
	acts_as_followable
	acts_as_follower




   	def fullname
   		if self.firstname.blank? and self.lastname.blank?
   			""
   		elsif self.firstname.blank?
   			"#{self.lastname}"
   		elsif self.lastname.blank?
   			"#{self.firstname}"
   		else
 			"#{self.firstname} #{self.lastname}"
 		end
 	end


	def find_country_travel_record(country)
		self.country_travel_records.each do |record|
	  		if record.country_id == country.id
	  			@is_found = true;
	  			@country_travel_record_id = record.id
	    	end
	    end
	    if @is_found
	    	@country_travel_record_id
	    else
	    	nil
	    end	
	end

	def country_travel_records_wannavisit
		CountryTravelRecord.where(user_id: self.id, travel_status: "wannavisit").order("country_id ASC")
	end

	def country_travel_records_havebeen
		CountryTravelRecord.where(user_id: self.id, travel_status: "havebeen").order("country_id ASC")
	end

	def have_added_country(country)
		have_added =  false
		CountryTravelRecord.where(user_id: self.id).each do |record|
			have_added = true if record.country_id == country.id
		end

		have_added
	end
end
