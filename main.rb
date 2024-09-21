require 'csv'
require 'countries'
require 'gruff'

data = {}
total_events = 0

CSV.foreach('sample.csv', headers: true) do |row|
	country_code = row['USER_COUNTRY']
	events_count = row['EVENT_COUNT'].to_i

	data[country_code] = events_count
	total_events += events_count
end

puts "Total Events Count: #{total_events}"

data_with_country_names = {}
data.each do |country_code, events_count|
	country = ISO3166::Country[country_code]
  country_name = country ? country.translations['en'] || country.name : country_code
  data_with_country_names[country_name] = events_count
end
