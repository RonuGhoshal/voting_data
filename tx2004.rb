require 'nokogiri'
require 'open-uri'
require 'pp'


counties_array = []

url = "http://uselectionatlas.org/RESULTS/datagraph.php?year=2004&fips=48&f=1&off=0&elect=0"

page = Nokogiri::HTML(open(url))

table_rows = page.css('.info tr').map{|row| row.children.map{|x| x.text}}
table_rows.each do |row|
  row = row.select! {|field| field != " "}
end

# 66..67
# 587.588
#630
#644
#649


# counties = []
# (0..899).each do |i|
#   if i%3 == 0
#       counties.push(table_rows[i].concat(table_rows[i+1].concat(table_rows[i+2])))
#   end
# end



# counties.each do |county|
#   counties_array.push ({"county name": county[0], "d_percent": county[2], "d_total": county[3], "r_percent": county[5], "r_total": county[6], "o_percent": county[8], "o_total": county[9]})
# end

