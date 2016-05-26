require 'nokogiri'
require 'open-uri'
require 'pp'

counties_array = []

(1..51).each do |index|

  url = "http://uselectionatlas.org/RESULTS/datagraph.php?year=2012&fips=#{index}&f=1&off=0&elect=0"

  page = Nokogiri::HTML(open(url))

  table_rows = page.css('.info tr').map{|row| row.children.map{|x| x.text}}
  table_rows.each do |row|
    row = row.select! {|field| field != " "}
  end

  if index != 40

    counties = []
    (0..table_rows.length-1).each do |i|
      if i%3 == 0
        counties.push(table_rows[i].concat(table_rows[i+1].concat(table_rows[i + 2])))
      end
    end

    counties.each do |county|
      counties_array.push ({"county name": county[0], "d_percent": county[2], "d_total": county[3], "r_percent": county[5], "r_total": county[6], "o_percent": county[8], "o_total": county[9] })
    end

  else
    counties = []
    (0..table_rows.length-1).each do |i|
      if i%2 == 0
        counties.push(table_rows[i].concat(table_rows[i+1]))
      end
    end

    counties.each do |county|
      counties_array.push ({"county name": county[0], "d_percent": county[2], "d_total": county[3], "r_percent": county[5], "r_total": county[6], "o_percent": 0, "o_total": 0})
    end
  end
end

p counties_array.length