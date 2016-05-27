require 'csv'
require_relative "2004data.csv"
require_relative "2008data.csv"

counties_04 = File.new("2004data.csv").to_a.join()
counties_2004 = (CSV.new(counties_04, :headers => true, :header_converters => :symbol)).to_a.map {|row| row.to_hash}

pp counties_2004