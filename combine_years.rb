require 'csv'

data12 = File.new('modified2012data.csv')
parsed12 = data12.to_a.join()
csv_data12 = (CSV.new(parsed12, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data08 = File.new('modified2008data.csv')
parsed08 = data08.to_a.join()
csv_data08 = (CSV.new(parsed08, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

csv_data08.each do |row08|
  csv_data12.each do |row12|
    if row08[:id] == row12[:id] && row08[:county_name] == row12[:county_name]
      row08["margin12"] = row12[:margin].to_f
    end
  end
end

CSV.open("transitions08_to_12.csv", "wb") do |csv|
  csv << ["state", "county_name", "margin08", "id", "margin12"]
  csv_data08.each do |row|
    csv << row.values
  end
end