# CSV properties
# row[0] => OrganisationID
# row[1] => OrganisationCode
# row[2] => OrganisationType
# row[3] => SubType
# row[4] => Sector
# row[5] => OrganisationStatus
# row[6] => IsPimsManaged
# row[7] => OrganisationName
# row[8] => Address1
# row[9] => Address2
# row[10] => Address3
# row[11] => City
# row[12] => County
# row[13] => Postcode
# row[14] => Latitude
# row[15] => Longitude
# row[16] => ParentODSCode
# row[17] => ParentName
# row[18] => Phone
# row[19] => Email
# row[20] => Website
# row[21] => Fax

puts 'Importing hospitals... '
CSV.foreach('/Users/pdurbin/Workspace/nhs/geo-json/data/Hospital.csv', encoding: 'windows-1251:utf-8', col_sep: '¬', headers: :first_row) do |row|
  next if row['Latitude'].nil?

  properties = {}
  row.each do |key, value|
    properties[key] = value unless value.nil? || ['OrganisationID', 'Latitude', 'Longitude'].include?(key)
  end

  Service.create({ service_id: row[0], location: [row[14].to_f, row[15].to_f], properties: properties, type: 'hospital' })
end
puts 'Done.'