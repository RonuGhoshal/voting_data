require 'csv'

data92 = File.new('modified1992data.csv')
parsed92 = data92.to_a.join()
csv_data92 = (CSV.new(parsed92, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data88 = File.new('modified1988data.csv')
parsed88 = data88.to_a.join()
csv_data88 = (CSV.new(parsed88, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

csv_data88.each do |row88|
  csv_data92.each do |row92|
    if row88[:id] == row92[:id] && row88[:county_name] == row92[:county_name]
      row88["percent_change"] = row92[:margin].to_f - row88[:margin].to_f
    end
  end
end

CSV.open("change88to92.csv", "wb") do |csv|
  csv << ["state", "county_name", "margin88", "id", "percent_change"]
  csv_data88.each do |row|
    csv << row.values
  end
end