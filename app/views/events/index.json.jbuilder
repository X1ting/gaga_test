json.events @events do |event|
  json.name  event.name
  json.start_at  event.start_at.to_formatted_s :long
  json.end_at  event.end_at.to_formatted_s :long
  json.longitude  event.longitude
  json.latitude  event.latitude
  json.address  event.address
  json.games event.games
end
