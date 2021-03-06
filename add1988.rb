require 'csv'

data = File.new('new_modified1988data.csv')
parsed_data = data.to_a.join()
data_1988= (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data = File.new('datasofar21.csv')
parsed_data = data.to_a.join()
data_so_far= (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data_so_far.each do |row_so_far|
  data_1988.each do |row88|
    if row_so_far[:id].to_i == row88[:id].to_i
      row_so_far['1988'] = row88[:hex_color]
    end
  end
end

p data_so_far[0]
CSV.open("datasofar22.csv", "wb") do |csv|
  csv << ["id","1912","1916","1920","1924","1928","1932","1936","1940","1944","1948","1956","1964","1968","1972","1976","1980","1984","1988","1992", "1996", "2000", "2004", "2008", "2012"]
  data_so_far.each do |row|
    csv << [row[:id], row[:"1912"], row[:"1916"], row[:"1920"], row[:"1924"], row[:"1928"], row[:"1932"], row[:"1936"], row[:"1940"], row[:"1944"], row[:"1948"], row[:"1956"], row[:"1964"], row[:"1968"], row[:"1972"], row[:"1976"], row[:"1980"],row[:"1984"],row["1988"],row[:"1992"], row[:"1996"], row[:"2000"], row[:"2004"], row[:"2008"], row[:"2012"]]
  end
end