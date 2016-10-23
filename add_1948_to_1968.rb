require 'csv'

data = File.new('modified1948data.csv')
parsed_data = data.to_a.join()
data_1948 = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data = File.new('1968_hex_colors.csv')
parsed_data = data.to_a.join()
data_1968 = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data_1968.each do |row68|
  data_1948.each do |row48|
    if row68[:id] == row48[:id]
      row68['1948'] = row48[:hex_color]
    end
  end
end

data_1968.each do |row|
  puts row
end

CSV.open("data48and68.csv", "wb") do |csv|
  csv << ["id", "1948", "1968"]
  data_1968.each do |row|
    csv << [row[:id], row["1948"], row[:"1968"]]
  end
end