FactoryBot.define do
  factory :user do
    prefix { ["Dr.", "Ms.", "Mr.", "Mrs.", "Prof."].sample }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { "Pass_w0rd"}
    password_confirmation { "#{password}"}
    admin { 'false' }
    department {[
      "Engineering",
      "Science"].sample
    }
    city { Faker::Address.city }
    country { Faker::Address.country }
    position { [ "research_scientist",
               "professor",
               "phd",
               "faculty",
               "doctoral_student",
               "masteral_student",
               "college_student",
               "highschool_student",
               "other"].sample
    }
    university_institute_company { Faker::University.name }

    #uncomment this to correct the error in login and request spec: ActiveRecord::RecordInvalid:
      #Validation failed: Kind is not included in the list, Kind can't be blank, Fee can't be blank
    # after(:create) do |user|
    #   user.abstracts << FactoryBot.create(:abstract)
    # end
  end
end
