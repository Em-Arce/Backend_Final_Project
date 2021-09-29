require "rails_helper"

RSpec.describe "Edits an Abstract", type: :feature do
  let(:create_user) { create(:user, prefix: "Ms.", position: "research_scientist") }
  let(:create_coauthor1) { create(:user, prefix: "Dr.", position: "phd") }
  let(:create_coauthor2) { create(:user, prefix: "Dr.", position: "faculty") }
  let(:create_abstract) { create(:abstract, main_author: create_user.id,
      keywords: "key1, key2", references: "\r\n [1] ref1.\r\n [2] ref2.\r\n" ) }
  let(:create_participation) { create(:participation, user_id: create_user.id,
    abstract_id: create_abstract.id ) }

  before do
    create_coauthor1
    create_coauthor2
    login_as(create_user, scope: :user)
    visit new_user_abstract_path(create_user.id)
    fill_in 'abstract[title]', with: create_abstract.title
    page.find("#abstract_main_author option[value=#{create_user.id}]").select_option
    page.find("#abstract_co_authors option[value=#{create_coauthor1.id}]").select_option
    page.find("#abstract_co_authors option[value=#{create_coauthor2.id}]").select_option
    fill_in 'abstract[corresponding_author_email]', with: 'example@gmail.com'
    fill_in 'abstract[keywords]', with: create_abstract.keywords
    fill_in 'abstract[body]', with: create_abstract.body
    fill_in 'abstract[references]', with: create_abstract.references
    find('input[type="submit"]').click
    abstract = Abstract.last
    create_participation
    #binding.pry
    find("a[href='/users/#{create_user.id}/abstracts/#{abstract.id}/edit']").click
  end

  describe 'with valid data' do
    it 'is successful'  do
      #find("a[href='/users/#{create_user.id}/abstracts/#{abstract.id}/edit']").click
      fill_in 'abstract[title]', with: "#{create_abstract.title} edited"
      page.find("#abstract_main_author option[value=#{create_user.id}]").select_option
      page.find("#abstract_co_authors option[value=#{create_coauthor1.id}]").select_option
      page.find("#abstract_co_authors option[value=#{create_coauthor2.id}]").select_option
      fill_in 'abstract[corresponding_author_email]', with: 'newemail@gmail.com'
      fill_in 'abstract[keywords]', with: create_abstract.keywords
      fill_in 'abstract[body]', with: create_abstract.body
      fill_in 'abstract[references]', with: create_abstract.references
      find('input[type="submit"]').click
      abstract = Abstract.last
      expect(abstract.title).to eq("#{create_abstract.title} edited")
      expect(abstract.corresponding_author_email).to eq("newemail@gmail.com")
    end
  end

  describe 'with invalid data:' do
    it 'blank title fails'  do
      fill_in 'abstract[title]', with: ""
      page.find("#abstract_main_author option[value=#{create_user.id}]").select_option
      page.find("#abstract_co_authors option[value=#{create_coauthor1.id}]").select_option
      page.find("#abstract_co_authors option[value=#{create_coauthor2.id}]").select_option
      fill_in 'abstract[corresponding_author_email]', with: 'newemail@gmail.com'
      fill_in 'abstract[keywords]', with: create_abstract.keywords
      fill_in 'abstract[body]', with: create_abstract.body
      fill_in 'abstract[references]', with: create_abstract.references
      find('input[type="submit"]').click
      abstract = Abstract.last
      expect(page).to have_content("Title can't be blank")
      expect(abstract.title).to eq create_abstract.title
      expect(abstract.corresponding_author_email).to eq create_abstract.corresponding_author_email
    end
  end
end
