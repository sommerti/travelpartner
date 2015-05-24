# == Schema Information
#
# Table name: countries
#
#  id             :integer          not null, primary key
#  country_code   :string
#  country_name   :string
#  continent_name :string
#  continent_code :string
#  created_at     :datetime
#  updated_at     :datetime
#  latitude       :float
#  longitude      :float
#

class Country < ActiveRecord::Base
	has_many :country_travel_records

	scope :in_asia, -> { where(continent_name: "Asia") }
	scope :in_europe, -> { where(continent_name: "Europe") }
	scope :in_northamerica, -> { where(continent_name: "North America") }
	scope :in_southamerica, -> { where(continent_name: "South America") }
	scope :in_africa, -> { where(continent_name: "Africa") }
	scope :in_oceania, -> { where(continent_name: "Oceania") }
	scope :in_antarctica, -> { where(continent_name: "Antarctica") }

	geocoded_by :country_name
	after_validation :geocode, if: :country_name_changed? 

	include PgSearch
	pg_search_scope :search, against: :country_name

	def self.text_search(query)
		search(query)
	end

end
