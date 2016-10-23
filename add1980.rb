require 'csv'

data = File.new('modified1980data.csv')
parsed_data = data.to_a.join()
data_1980 = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data = File.new('datasofar11.csv')
parsed_data = data.to_a.join()
data_so_far= (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data_so_far.each do |row_so_far|
  data_1980.each do |row80|
    if row_so_far[:id].to_i == row80[:id].to_i
      row_so_far['1980'] = row80[:hex_color]
    end
  end
end

p data_so_far[0]

CSV.open("datasofar12.csv", "wb") do |csv|
  csv << ["id","1924","1928","1932","1936","1940","1944","1948","1956","1964","1968","1972","1976","1980","1992"]
  data_so_far.each do |row|
    csv << [row[:id], row[:"1924"], row[:"1928"], row[:"1932"], row[:"1936"], row[:"1940"], row[:"1944"], row[:"1948"], row[:"1956"], row[:"1964"], row[:"1968"], row[:"1972"], row[:"1976"], row["1980"],row[:"1992"]]
  end
end