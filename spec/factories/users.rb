FactoryBot.define do
  factory :user do
    prefix { 'Prof.' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6, max_length: 128,
          mix_case: true, special_characters: true) }
    password_confirmation { "#{password}"}
    admin { 'false' }
  end
end
