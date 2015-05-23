class CountryTravelRecord < ActiveRecord::Base
  belongs_to :country
  belongs_to :user
end
