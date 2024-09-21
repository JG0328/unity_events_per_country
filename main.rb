# frozen_string_literal: true

require 'csv'
require 'countries'
require 'gruff'

data = {}
total_events = 0

CSV.foreach('sample.csv', headers: true) do |row|
  country_code = row[0]
  events_count = row[1].to_i
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

sorted_data = data_with_country_names.sort_by { |country, events_count| events_count }.reverse
max_slices = 10
if sorted_data.size > max_slices
  grouped_data = sorted_data.first(max_slices - 1).to_h
  others_count = sorted_data.drop(max_slices - 1).map { |country, events_count| events_count }.sum
  grouped_data['Others'] = others_count
else
  grouped_data = sorted_data
end

g = Gruff::Pie.new
g.title = 'Events by Country'

grouped_data.each do |country, events_count|
  g.data(country, events_count)
end

g.write('sample_pie.png')
