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
#

class Country < ActiveRecord::Base
end
