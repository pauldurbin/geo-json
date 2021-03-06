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

puts 'Importing dentists... '
CSV.foreach('/Users/pdurbin/Workspace/nhs/geo-json/data/Dentists.csv', encoding: 'windows-1251:utf-8', col_sep: '¬', headers: :first_row) do |row|
  next if row['Latitude'].nil?

  properties = {}
  row.each do |key, value|
    properties[key] = value unless value.nil? || ['OrganisationID', 'Latitude', 'Longitude'].include?(key)
  end

  Service.create({ service_id: row[0], location: [row[13].to_f, row[14].to_f], properties: properties, type: 'dentist' })
end
puts 'Done.'
