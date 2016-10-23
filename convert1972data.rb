require 'csv'

data = File.new('1972.csv')
parsed_data = data.to_a.join()
csv_data = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

csv_data.each do |row|
    if row[:other] == "-"
      row[:other] = 0
    end
    if row[:other2] == "-"
      row[:other2] = 0
    end
    row[:other] = (row[:other].to_f + row[:other2].to_f).to_s + "%"
    row[:mcgovern] = (("100%").to_f - (row[:nixon].to_f + row[:other].to_f))
    if row[:mcgovern] == 100
      row[:mcgovern] = 0
    end
  rgb = [row[:nixon], row[:other], row[:mcgovern]].map do |candidate|
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


CSV.open("modified1972data.csv", "wb") do |csv|
  csv << ["id", "margin", "nixon", "mcgovern", "other", "other2", "hex_color"]
  csv_data.each do |row|
    csv << row.values
  end
end