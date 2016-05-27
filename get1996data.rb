require 'nokogiri'
require 'open-uri'
require 'pp'
require 'csv'

counties_array = []

(1..56).each do |index|
  p index
  url = "http://uselectionatlas.org/RESULTS/datagraph.php?year=1996&fips=#{index}&f=1&off=0&elect=0"

  page = Nokogiri::HTML(open(url))

  table_rows = page.css('.info tr').map{|row| row.children.map{|x| x.text}}
  table_rows.each do |row|
    row = row.select! {|field| field != " "}
  end

  if index == 2
    table_rows.insert(163, ["Other", "0", "0"])
  end

  if index == 13
    table_rows.insert(604, ["Other", "0", "0"])
    table_rows.insert(521, ["Other", "0", "0"])
    table_rows.insert(470, ["Other", "0", "0"])
    table_rows.insert(247, ["Other", "0", "0"])
  end

  if index == 31
    table_rows.insert(342, ["Other", "0", "0"])
    table_rows.insert(11, ["Other", "0", "0"])
  end

  if index == 48
    table_rows.insert(600, ["Other", "0", "0"])
    table_rows.insert(521, ["Other", "0", "0"])
    table_rows.insert(310, ["Other", "0", "0"])
    table_rows.insert(303, ["Other", "0", "0"])
  end

  counties = []
  (0..table_rows.length-1).each do |i|
    if i%4 == 0
      counties.push(table_rows[i].concat(table_rows[i+1].concat(table_rows[i + 2].concat(table_rows[i+3]))))
    end
  end

  counties.each do |county|
  counties_array.push ({"state_index": index, "county_name": county[0], "d_percent": county[2], "d_total": county[3], "r_percent": county[5], "r_total": county[6], "i_percent": county[8] || "0", "i_total": county[9] || "0", "o_percent": county[11] || "0", "o_total": county[12] || "0" })
  end

end


counties_array.each do |county|
  county[:d_percent] = county[:d_percent].gsub("%", "").to_f
  county[:r_percent] = county[:r_percent].gsub("%", "").to_f
  county[:i_percent] = county[:i_percent].gsub("%", "").to_f
  county[:o_percent] = county[:o_percent].gsub("%", "").to_f
  county[:d_total] = county[:d_total].gsub(",", "").to_i
  county[:r_total] = county[:r_total].gsub(",", "").to_i
  county[:i_total] = county[:i_total].gsub(",", "").to_i
  county[:o_total] = county[:o_total].gsub(",", "").to_i
end


CSV.open("1996data.csv", "wb") do |csv|
  counties_array.each do |county|
    csv << county.values
  end
end

