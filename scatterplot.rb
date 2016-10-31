require 'csv'

data = File.new('new_modified2012data.csv')
parsed_data = data.to_a.join()
csv_data = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}


counties = File.new('county_facts.csv')
parsed_data = counties.to_a.join()
county_data = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

county_data.each do |county|
  csv_data.each do |row|
    if row[:id].to_i == county[:fips].to_i
      county[:margin] = row[:romney].to_f - row[:obama].to_f
    end
  end
end
p county_data[3]

CSV.open("scatterplot3.csv", "wb") do |csv|
  csv << ["id", "margin", "wh"]
  county_data.each do |row|
      csv << [row[:fips], row[:margin], row[:rhi225214]]
  end
end