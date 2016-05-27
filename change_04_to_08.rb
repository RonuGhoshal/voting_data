require 'csv'

counties_w_change = []
counties_04 = File.new("2004data.csv").to_a.join()
counties_2004 = (CSV.new(counties_04, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

counties_08 = File.new("2008data.csv").to_a.join()
counties_2008 = (CSV.new(counties_08, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

for county in counties_2004
  name = county[:county_name]
  state = county[:state_index]
  d_percent = county[:d_percent]
  o_percent = county[:o_percent]

  matcher = counties_2008.find {|county08| (county08[:county_name] == name && county08[:state_index] == state)}



  if matcher
    diff_dem = (matcher[:d_percent].to_f - d_percent.to_f).round(2)
    diff_other = (matcher[:o_percent].to_f - o_percent.to_f).round(2)
  counties_w_change.push({"state": matcher[:state_index], "name": matcher[:county_name], "diff_other": diff_other})
  end

end

sorted = counties_w_change.sort_by {|county| county[:diff_other]}

p sorted[0..9]
p sorted[-10..-1]