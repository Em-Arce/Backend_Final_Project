FactoryBot.define do
  factory :participation do
    fee { "Php 500" }
    kind { "student_local" }
    association :user
    association :abstract
  end
end
