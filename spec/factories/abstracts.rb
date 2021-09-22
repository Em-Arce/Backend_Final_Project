FactoryBot.define do
  factory :abstract do
    title { "MyString" }
    main_author { "MyString" }
    co_authors { ["string", "another string"] }
    corresponding_author_email { Faker::Internet.unique.email }
    keywords { ["string", "another string"]}
    body { "MyText" }
    references { ["string", "another string"] }
  end
end
