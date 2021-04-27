require 'faker'
User.delete_all
Game.delete_all
GameSession.delete_all

# seed students
10.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::String.random(length: 7..12))
end
User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::String.random(length: 7..12),
            id: 23_456)
Game.create(id: 20_000)
GameSession.create(user_id: 23_456, game_id: 20_000)
