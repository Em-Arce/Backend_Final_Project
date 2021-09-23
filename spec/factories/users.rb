FactoryBot.define do
  factory :user do
    prefix { 'Prof.' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { "Pass_word0"}
    password_confirmation { "#{password}"}
    admin { 'false' }

    after(:create) do |user|
      user.abstracts << FactoryBot.create(:abstract)
    end
  end
end
