require 'nokogiri'
require 'open-uri'
require 'pp'





counties_array = []

url = "http://uselectionatlas.org/RESULTS/datagraph.php?year=1984&fips=12&f=1&off=0&elect=0"

page = Nokogiri::HTML(open(url))

table_rows = page.css('.info tr').map{|row| row.children.map{|x| x.text}}
table_rows.each do |row|
  row = row.select! {|field| field != " "}
end

#5
#10
#27
#32
#37
#48
#56
#64
#84
#122
#163
#165
#173
#175

p table_rows[56..58]