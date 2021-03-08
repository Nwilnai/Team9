
require 'faker'
User.delete_all

#seed students
10.times do
    User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::String.random(length: 7..12))
end

