require 'csv'

data = File.new('1960.csv')
parsed_data = data.to_a.join()
csv_data = (CSV.new(parsed_data, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

csv_data.each do |row|
  row[:other] = (100 - (row[:nixon].to_f + row[:kennedy].to_f)).to_s + "%"
  if row[:other].to_i == 100
    row[:other] = 0
  end
  rgb = [row[:nixon], row[:other], row[:kennedy]].map do |candidate|
      if candidate == "-"
        0
      else
        (candidate.to_f * 2.55).to_i
      end
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

p csv_data[0]

CSV.open("new_modified1960data.csv", "wb") do |csv|
  csv << ["id", "margin", "nixon", "kennedy", "other", "hex_color"]
  csv_data.each do |row|
    csv << row.values
  end
end