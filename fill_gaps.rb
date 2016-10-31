require 'csv'

data = File.new('datasofar22.csv')
parsed_data = data.to_a.join()
data_so_far= (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data_so_far.select {|row| row[:id] == "4012"}[0].each do |year, value|
  if value == "000000"
    value = data_so_far.select {|row| row[:id] == "4027"}[0][year]
  end
end

CSV.open("datasofar.csv23", "wb") do |csv|
  csv << ["id", "1948", "1968", "1992"]
  data_so_far.each do |row|
    csv << row.values
  end
end