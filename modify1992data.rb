require 'csv'

data = File.new('1992data.csv')
parsed_data = data.to_a.join()
csv_data = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

fips = File.new('fips.csv')
parsed_fips = fips.to_a.join()
csv_fips = (CSV.new(parsed_fips, :headers => true, :header_converters => :symbol)).to_a.select{|row| row[:entity_description] == "County"}.map {|row| row.to_hash}
csv_fips.map {|row| row[:fips_code] = row[:state_fips_code].to_s + row[:county_fips_code].to_s}


modified_csv_data = []
csv_data.each do |row|
  modified_csv_data.push([row[:state_index], row[:county_name], row[:d_percent].to_f - row[:r_percent].to_f])
end
modified_csv_data.each do |row|
  csv_fips.each do |fips_row|
    if row[0].to_i == fips_row[:state_fips_code].to_i && row[1] == fips_row[:gu_name]
      row[3] = (fips_row[:state_fips_code]).to_s + (fips_row[:county_fips_code]).to_s
    end
  end
end



CSV.open("modified1992data.csv", "wb") do |csv|
  csv << ["state", "county_name", "margin", "id"]
  modified_csv_data.each do |row|
    csv << row
  end
end