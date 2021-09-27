FactoryBot.define do
  factory :abstract do
    title { "TITLE OF ABSTRACT" }
    main_author { Faker::Name.name }
    co_authors { ["First Name LAST NAME1", "First Name LAST NAME2"] }
    corresponding_author_email { Faker::Internet.unique.email }
    keywords { ["string", "string1"]}
    body { "Abstracts must be written in English and should not exceed one (1) page. Texts of the abstract must be single spaced in Times New Roman, font size 12 and both left and right justified. " }
    references { ["[1] K. Taaca and M. Vasquez Jr. Micropor. Mesopor. Mat. 2017, 241, 383-391", "[2] K. Taaca and M. Vasquez Jr. Micropor. Mesopor. Mat. 2017, 241, 383-391"] }
  end
end
