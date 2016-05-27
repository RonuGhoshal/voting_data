require 'nokogiri'
require 'open-uri'
require 'pp'
require 'csv'

counties_array = []

(1..51).each do |index|
  p index
  url = "http://uselectionatlas.org/RESULTS/datagraph.php?year=2004&fips=#{index}&f=1&off=0&elect=0"

  page = Nokogiri::HTML(open(url))

  table_rows = page.css('.info tr').map{|row| row.children.map{|x| x.text}}
  table_rows.each do |row|
    row = row.select! {|field| field != " "}
  end

  if index == 31
    table_rows.insert(14, ["Other", "0", "0"])
  elsif index == 48
    table_rows.insert(649, ["Other", "0", "0"])
    table_rows.insert(644, ["Other", "0", "0"])
    table_rows.insert(630, ["Other", "0", "0"])
    table_rows.insert(589, ["Other", "0", "0"])
    table_rows.insert(68, ["Other", "0", "0"])
  end

  if index == 40
    counties = []
    (0..table_rows.length-1).each do |i|
      if i%2 == 0
        counties.push(table_rows[i].concat(table_rows[i+1]))
      end
    end


  else

    counties = []
    (0..table_rows.length-1).each do |i|
      if i%3 == 0
        counties.push(table_rows[i].concat(table_rows[i+1].concat(table_rows[i + 2])))
      end
    end
  end

  counties.each do |county|
  counties_array.push ({"state_index": index, "county_name": county[0], "d_percent": county[2], "d_total": county[3], "r_percent": county[5], "r_total": county[6], "o_percent": county[8] || "0", "o_total": county[9] || "0"})
  end

end

counties_array.each do |county|
  county[:d_percent] = county[:d_percent].gsub("%", "").to_f
  county[:r_percent] = county[:r_percent].gsub("%", "").to_f
  county[:o_percent] = county[:o_percent].gsub("%", "").to_f
  county[:d_total] = county[:d_total].gsub(",", "").to_i
  county[:r_total] = county[:r_total].gsub(",", "").to_i
  county[:o_total] = county[:o_total].gsub(",", "").to_i
end

# CSV.open("2004data.csv", "wb") do |csv|
#   counties_array.each do |county|
#     csv << county.values
#   end
# end