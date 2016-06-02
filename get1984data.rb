require 'nokogiri'
require 'open-uri'
require 'pp'
require 'csv'

counties_array = []

(1..56).each do |index|
  p index
  url = "http://uselectionatlas.org/RESULTS/datagraph.php?year=1984&fips=#{index}&f=1&off=0&elect=0"

  page = Nokogiri::HTML(open(url))

  table_rows = page.css('.info tr').map{|row| row.children.map{|x| x.text}}
  table_rows.each do |row|
    row = row.select! {|field| field != " "}
  end

  if index != 29
    if index == 12
      table_rows.insert(175, ["Other", "0", "0"])
      table_rows.insert(173, ["Other", "0", "0"])
      table_rows.insert(165, ["Other", "0", "0"])
      table_rows.insert(163, ["Other", "0", "0"])
      table_rows.insert(122, ["Other", "0", "0"])
      table_rows.insert(99, ["Other", "0", "0"])
      table_rows.insert(97, ["Other", "0", "0"])
      table_rows.insert(95, ["Other", "0", "0"])
      table_rows.insert(84, ["Other", "0", "0"])
      table_rows.insert(79, ["Other", "0", "0"])
      table_rows.insert(77, ["Other", "0", "0"])
      table_rows.insert(75, ["Other", "0", "0"])
      table_rows.insert(64, ["Other", "0", "0"])
      table_rows.insert(62, ["Other", "0", "0"])
      table_rows.insert(60, ["Other", "0", "0"])
      table_rows.insert(64, ["Other", "0", "0"])
      table_rows.insert(58, ["Other", "0", "0"])
      table_rows.insert(56, ["Other", "0", "0"])
      table_rows.insert(48, ["Other", "0", "0"])
      table_rows.insert(37, ["Other", "0", "0"])
      table_rows.insert(32, ["Other", "0", "0"])
      table_rows.insert(27, ["Other", "0", "0"])
      table_rows.insert(10, ["Other", "0", "0"])
      table_rows.insert(5, ["Other", "0", "0"])
    end



    if index == 15
      table_rows.insert(14, ["Other", "0", "0"])
    end

    if index == 26
      table_rows.insert(125, ["Other", "0", "0"])
    end

    if index == 31
      table_rows.insert(8, ["Other", "0", "0"])
      table_rows.insert(13, ["Other", "0", "0"])
    end

    if index == 41
      table_rows.insert(104, ["Other", "0", "0"])
    end

    if index == 48
      table_rows.insert(587, ["Other", "0", "0"])
      table_rows.insert(465, ["Other", "0", "0"])
      table_rows.insert(451, ["Other", "0", "0"])
      table_rows.insert(404, ["Other", "0", "0"])
    end

    if index == 49
      table_rows.insert(47, ["Other", "0", "0"])
    end

    counties = []
    (0..table_rows.length-1).each do |i|
      if i%3 == 0
        counties.push(table_rows[i].concat(table_rows[i+1].concat(table_rows[i + 2])))
      end
    end

  else

    counties = []
    (0..table_rows.length-1).each do |i|
      if i%2 == 0
        counties.push(table_rows[i].concat(table_rows[i+1]))
      end
    end

  end

    counties.each do |county|
    counties_array.push ({"state_index": index, "county_name": county[0], "d_percent": county[2], "d_total": county[3], "r_percent": county[5], "r_total": county[6], "o_percent": county[8] || "0", "o_total": county[9] || "0" })
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


  CSV.open("1984data.csv", "wb") do |csv|
    counties_array.each do |county|
      csv << county.values
    end
  end




