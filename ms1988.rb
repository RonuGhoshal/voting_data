require 'nokogiri'
require 'open-uri'
require 'pp'


counties_array = []

url = "http://uselectionatlas.org/RESULTS/datagraph.php?year=1988&fips=28&f=1&off=0&elect=0"

page = Nokogiri::HTML(open(url))

table_rows = page.css('.info tr').map{|row| row.children.map{|x| x.text}}
table_rows.each do |row|
  row = row.select! {|field| field != " "}
end

#35

p table_rows[230..232]