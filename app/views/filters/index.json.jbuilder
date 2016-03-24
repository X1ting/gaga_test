json.filters @filters do |filter|
  json.id  filter.id
  json.start_time  filter.start_time
  json.end_time  filter.end_time
  json.distance  filter.distance
  json.day_of_start  filter.day_of_start_int
  json.day_of_start_readable  filter.day_of_start
  json.games filter.games
end
