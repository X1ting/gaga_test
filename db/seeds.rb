# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do
  Game.create(name: Faker::Book.genre)
end

10.times do
  Event.create(
    name: Faker::App.name,
    start_at: DateTime.now - rand(4).days,
    end_at: DateTime.now + rand(4).days,
    longitude: Faker::Address.longitude,
    latitude: Faker::Address.latitude,
    games: Game.all.sample(rand(4))
  )
end