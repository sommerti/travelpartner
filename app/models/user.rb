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

   	def fullname
 		"#{self.firstname} #{self.lastname}"
 	end
end
