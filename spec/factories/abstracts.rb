FactoryBot.define do
  factory :abstract do
    title { "MyString" }
    main_author { "MyString" }
    co_authors { "MyString" }
    body { "MyText" }
    participation { nil }
  end
end
