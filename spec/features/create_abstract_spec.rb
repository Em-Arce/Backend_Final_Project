require "rails_helper"

RSpec.describe "Creates an Abstract", type: :feature do
  let(:create_user) { create(:user, prefix: "Ms.", position: "research_scientist") }
  let(:create_coauthor1) { create(:user, prefix: "Dr.", position: "phd") }
  let(:create_coauthor2) { create(:user, prefix: "Dr.", position: "faculty") }
  let(:create_abstract) { create(:abstract, main_author: create_user.id,
      keywords: "key1, key2", references: "\r\n [1] ref1.\r\n [2] ref2.\r\n" ) }

  before do
    create_coauthor1
    create_coauthor2
    login_as(create_user, scope: :user)
    visit static_pages_welcome_path
    #find("a[href='users/#{create_user.id}/abstracts/new']").click
    visit new_user_abstract_path(create_user.id)
  end

  describe 'is successful' do
    it 'with valid data'  do
      #binding.pry
      fill_in 'abstract[title]', with: create_abstract.title
      page.find("#abstract_main_author option[value=#{create_user.id}]").select_option
      page.find("#abstract_co_authors option[value=#{create_coauthor1.id}]").select_option
      page.find("#abstract_co_authors option[value=#{create_coauthor2.id}]").select_option
      fill_in 'abstract[corresponding_author_email]', with: create_abstract.corresponding_author_email
      fill_in 'abstract[keywords]', with: create_abstract.keywords
      fill_in 'abstract[body]', with: create_abstract.body
      fill_in 'abstract[references]', with: create_abstract.references
      find('input[type="submit"]').click
      #binding.pry
      abstract = Abstract.all.last
      expect(Abstract.find_by(id: abstract.id)).not_to eq(nil)
    end
  end
end
