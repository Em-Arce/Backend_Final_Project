# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#CREATE INITIAL LIST OF USERS IN DEV/TEST ENV ONLY!!!!
#when seed using faker, uncomment password validation in user.rb
require 'faker'

20.times do
  prefix = ["Dr.", "Ms.", "Mr.", "Mrs.", "Prof.", "Sir", "Dame"].sample
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.unique.email
  password = Faker::Internet.password(min_length: 6, max_length: 15,
   mix_case: true, special_characters: true)
  city = Faker::Address.city
  country = Faker::Address.country
  User.create!(prefix: prefix, first_name: first_name, last_name: last_name,
   email:email, password: password, password_confirmation: password, city: city,
   country: country )
end

#Add admin to PROD ENV
User.create!(prefix: "Ms.",
             first_name: "Kathrina Lois",
             last_name: "Taaca",
             email: "kathloistaaca@gmail.com",
             password: "Pass_word0",
             password_confirmation: "Pass_word0",
             admin: true,
             city: "Makati",
             country: "Philippines"
             )

User.create!(prefix: "Ms.",
             first_name: "Jane",
             last_name: "Doe",
             email: "railsnewappnotificationaug2021@gmail.com",
             password: "Pass_word0",
             password_confirmation: "Pass_word0",
             admin: true,
             city: "Quezon",
             country: "Philippines"
             )
