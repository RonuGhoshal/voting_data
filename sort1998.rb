require 'csv'

data = File.new('2000data.csv')
parsed_data = data.to_a.join()
csv_data = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

csv_data = csv_data.sort_by{|x| -(x[:o_percent].to_f)}.select{|s| s[:state_index] == "12"}

puts csv_data[0..9]