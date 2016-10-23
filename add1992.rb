require 'csv'

data = File.new('new_modified1992data.csv')
parsed_data = data.to_a.join()
data_1992 = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data = File.new('data48and68.csv')
parsed_data = data.to_a.join()
data_so_far= (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data_so_far.each do |row_so_far|
  data_1992.each do |row92|
    if row_so_far[:id].to_i == row92[:id].to_i
      row_so_far['1992'] = row92[:hex_color]
    end
  end
end


CSV.open("datasofar.csv", "wb") do |csv|
  csv << ["id", "1948", "1968", "1992"]
  data_so_far.each do |row|
    csv << row.values
  end
end