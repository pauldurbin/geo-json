# CSV properties
# row[0] => OrganisationID
# row[1] => OrganisationCode
# row[2] => OrganisationType
# row[3] => SubType
# row[4] => OrganisationStatus
# row[5] => IsPimsManaged
# row[6] => OrganisationName
# row[7] => Address1
# row[8] => Address2
# row[9] => Address3
# row[10] => City
# row[11] => County
# row[12] => Postcode
# row[13] => Latitude
# row[14] => Longitude
# row[15] => Phone
# row[16] => Email
# row[17] => Website
# row[18] => Fax

require 'sinatra/base'
require 'csv'
require 'json'
require 'mongo'

db = Connection.new.db('geo-json')
services = db.collection('services')

features = []

CSV.foreach('/Users/pdurbin/Workspace/nhs/geo-json/data/Dentists.csv', encoding: 'windows-1251:utf-8', col_sep: '¬', headers: :first_row) do |row|
  next if row['Latitude'].nil?

  properties = {}
  row.each do |key, value|
    properties[key] = value unless value.nil? || ['OrganisationID', 'Latitude', 'Longitude'].include?(key)
  end

  services.insert Hash.new({ id: row[0], coordinates: [row[14].to_f, row[13].to_f], properties: properties })

  print '.'
  # feature = {
  #   type: "Feature",
  #   id: row[0],
  #   geometry: {
  #     type: "Point",
  #     coordinates: [row[14].to_f, row[13].to_f]
  #   },
  #   properties: properties
  # }
  # features.push(feature)
end

# collection = {
#   type: 'FeatureCollection',
#   features: features
# }
# 
# File.open("public/geo-json/dentists.geojson", "w+") do |dentist|
#   dentist.puts collection.to_json
# end
