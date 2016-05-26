require 'nokogiri'
require 'open-uri'
require 'pp'


counties_array = []

url = "http://uselectionatlas.org/RESULTS/datagraph.php?year=2012&fips=40&f=1&off=0&elect=0"

page = Nokogiri::HTML(open(url))

table_rows = page.css('.info tr').map{|row| row.children.map{|x| x.text}}
table_rows.each do |row|
  row = row.select! {|field| field != " "}
end


counties = []
(0..table_rows.length-1).each do |i|
  if i%2 == 0
    counties.push(table_rows[i].concat(table_rows[i+1]))
  end
end

counties.each do |county|
  counties_array.push ({"county name": county[0], "d_percent": county[2], "d_total": county[3], "r_percent": county[5], "r_total": county[6], "o_percent": 0, "o_total": 0})
end

