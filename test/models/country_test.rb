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

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
