# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

25.times do
  User.create(email: Faker::Internet.email,
  password: Faker::Internet.password(8),
  user_name: Faker::Internet.user_name)
end

25.times do
  Sub.create(
    title: Faker::Book.title,
    description: Faker::Hacker.say_something_smart,
    moderator_id: rand(1..25)
  )
end
