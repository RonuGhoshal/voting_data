require 'csv'

data = File.new('new_modified1964data.csv')
parsed_data = data.to_a.join()
data_1964 = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data = File.new('datasofar2.csv')
parsed_data = data.to_a.join()
data_so_far= (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data_so_far.each do |row_so_far|
  data_1964.each do |row64|
    if row_so_far[:id].to_i == row64[:id].to_i
      row_so_far['1964'] = row64[:hex_color]
    end
  end
end


CSV.open("datasofar3.csv", "wb") do |csv|
  csv << ["id", "1948", "1956", "1964", "1968", "1992"]
  data_so_far.each do |row|
    csv << [row[:id], row[:"1948"], row[:"1956"], row["1964"], row[:"1968"], row[:"1992"]]
  end
end