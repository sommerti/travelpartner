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

require 'test_helper'

class CountryTravelRecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
