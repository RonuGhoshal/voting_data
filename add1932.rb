require 'csv'

data = File.new('modified1932data.csv')
parsed_data = data.to_a.join()
data_1932 = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data = File.new('datasofar6.csv')
parsed_data = data.to_a.join()
data_so_far= (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data_so_far.each do |row_so_far|
  data_1932.each do |row32|
    if row_so_far[:id].to_i == row32[:id].to_i
      row_so_far['1932'] = row32[:hex_color]
    end
  end
end



CSV.open("datasofar7.csv", "wb") do |csv|
  csv << ["id", "1932", "1936", "1940", "1944", "1948", "1956", "1964", "1968", "1992"]
  data_so_far.each do |row|
    csv << [row[:id], row["1932"], row[:"1936"], row[:"1940"], row[:"1944"], row[:"1948"], row[:"1956"], row[:"1964"], row[:"1968"], row[:"1992"]]
  end
end