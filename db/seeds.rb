# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

user_count = 50
messages   = 7500

user_count.times do
  User.create first_name: Faker::Name.first_name,
              last_name:  Faker::Name.last_name,
              email:      Faker::Internet.email,
              password:   'test1'
end

messages.times do
  Message.create sender:   User.find(rand(1..user_count)),
                 receiver: User.find(rand(1..user_count)),
                 content:  Faker::Lorem.sentence
end