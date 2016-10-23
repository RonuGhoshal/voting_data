require 'csv'

data = File.new('new_modified1956data.csv')
parsed_data = data.to_a.join()
data_1956 = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data = File.new('datasofar.csv')
parsed_data = data.to_a.join()
data_so_far= (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data_so_far.each do |row_so_far|
  data_1956.each do |row56|
    if row_so_far[:id].to_i == row56[:id].to_i
      row_so_far['1956'] = row56[:hex_color]
    end
  end
end


CSV.open("datasofar2.csv", "wb") do |csv|
  csv << ["id", "1948", "1956", "1968", "1992"]
  data_so_far.each do |row|
    csv << [row[:id], row[:"1948"], row["1956"], row[:"1968"], row[:"1992"]]
  end
end