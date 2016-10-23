require 'csv'

data = File.new('1956.csv')
parsed_data = data.to_a.join()
csv_data = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

csv_data.each do |row|
  rgb = [row[:eisenhower], row[:other], row[:stevenson]].map do |candidate|
      (candidate.to_f * 2.55).to_i
  end
  num_as_hex = ""
  rgb.each do |component|
    hex = component.to_s(16)
    if component < 16
      num_as_hex << "0#{hex}"
    else
      num_as_hex << hex
    end
    row[:hex_color] = num_as_hex
  end
end


CSV.open("new_modified1956data.csv", "wb") do |csv|
  csv << ["id", "margin", "eisenhower", "stevenson", "other", "hex_color"]
  csv_data.each do |row|
    csv << row.values
  end
end