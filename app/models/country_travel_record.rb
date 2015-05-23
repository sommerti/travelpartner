# == Schema Information
#
# Table name: country_travel_records
#
#  id            :integer          not null, primary key
#  country_id    :integer
#  user_id       :integer
#  travel_status :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CountryTravelRecord < ActiveRecord::Base
  belongs_to :country
  belongs_to :user
end
