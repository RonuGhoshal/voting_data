require 'csv'

data = File.new('modified1936data.csv')
parsed_data = data.to_a.join()
data_1936 = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data = File.new('datasofar5.csv')
parsed_data = data.to_a.join()
data_so_far= (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data_so_far.each do |row_so_far|
  data_1936.each do |row36|
    if row_so_far[:id].to_i == row36[:id].to_i
      row_so_far['1936'] = row36[:hex_color]
    end
  end
end



CSV.open("datasofar6.csv", "wb") do |csv|
  csv << ["id", "1936", "1940", "1944", "1948", "1956", "1964", "1968", "1992"]
  data_so_far.each do |row|
    csv << [row[:id], row["1936"], row[:"1940"], row[:"1944"], row[:"1948"], row[:"1956"], row[:"1964"], row[:"1968"], row[:"1992"]]
  end
end