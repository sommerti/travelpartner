class CreateCountryTravelRecords < ActiveRecord::Migration
  def change
    create_table :country_travel_records do |t|
      t.references :country, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :travel_status

      t.timestamps null: false
    end
  end
end
