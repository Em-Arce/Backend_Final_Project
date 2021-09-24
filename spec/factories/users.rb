FactoryBot.define do
  factory :user do
    prefix { 'Prof.' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { "Pass_word0"}
    password_confirmation { "#{password}"}
    admin { 'false' }

    #uncomment this to correct the error in login and request spec: ActiveRecord::RecordInvalid:
      #Validation failed: Kind is not included in the list, Kind can't be blank, Fee can't be blank
    # after(:create) do |user|
    #   user.abstracts << FactoryBot.create(:abstract)
    # end
  end
end
