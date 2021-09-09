# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

20.times do
  prefix = Faker::Name.prefix
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.unique.email
  password = Faker::Internet.password(min_length: 6, max_length: 15,
    mix_case: true, special_characters: true)
  User.create(prefix: prefix, first_name: first_name, last_name: last_name,
    email:email, password: password, password_confirmation: password )
end
