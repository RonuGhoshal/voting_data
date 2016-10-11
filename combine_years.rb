require 'csv'

data12 = File.new('modified2012data.csv')
parsed12 = data12.to_a.join()
csv_data12 = (CSV.new(parsed12, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data08 = File.new('modified2008data.csv')
parsed08 = data08.to_a.join()
csv_data08 = (CSV.new(parsed08, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data88 = File.new('modified1988data.csv')
parsed88= data88.to_a.join()
csv_data88 = (CSV.new(parsed88, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data92 = File.new('modified1992data.csv')
parsed92= data92.to_a.join()
csv_data92 = (CSV.new(parsed92, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

data04 = File.new('modified2004data.csv')
parsed04= data04.to_a.join()
csv_data04 = (CSV.new(parsed04, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

csv_data08.each do |row08|
  csv_data12.each do |row12|
    if row08[:id] == row12[:id] && row08[:county_name] == row12[:county_name]
      row08["margin12"] = row12[:margin].to_f
    end
  end

  csv_data88.each do |row88|
    if row08[:id] == row88[:id] && row08[:county_name] == row88[:county_name]
      row08["margin88"] = row88[:margin].to_f
    end
  end

  csv_data92.each do |row92|
    if row08[:id] == row92[:id] && row08[:county_name] == row92[:county_name]
      row08["margin92"] = row92[:margin].to_f
    end
  end

  csv_data04.each do |row04|
    if row08[:id] == row04[:id] && row08[:county_name] == row04[:county_name]
      row08["margin04"] = row04[:margin].to_f
    end
  end
end


CSV.open("transitions88_to_12.csv", "wb") do |csv|
  csv << ["state", "county_name", "margin08", "id", "margin12", "margin88", "margin92", "margin04"]
  csv_data08.each do |row|
    csv << row.values
  end
end