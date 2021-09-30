require "rails_helper"

RSpec.describe "Creates an Abstract", type: :feature do
  let(:create_user) { create(:user, prefix: "Ms.", position: "research_scientist") }
  let(:create_coauthor1) { create(:user, prefix: "Dr.", position: "phd") }
  let(:create_coauthor2) { create(:user, prefix: "Dr.", position: "faculty") }
  let(:create_abstract) { create(:abstract, main_author: create_user.id,
      keywords: "key1, key2", references: "\r\n [1] ref1.\r\n [2] ref2.\r\n" ) }
  # let(:create_participation) { create(:participation, user_id: create_user.id,
  #   abstract_id: Abstract.last.id ) }

  before do
    #binding.pry
    create_coauthor1
    create_coauthor2
    login_as(create_user, scope: :user)
    visit static_pages_welcome_path
    visit new_user_abstract_path(create_user.id)
    fill_in 'abstract[title]', with: create_abstract.title
    page.find("#abstract_main_author option[value=#{create_user.id}]").select_option
    page.find("#abstract_co_authors option[value=#{create_coauthor1.id}]").select_option
    page.find("#abstract_co_authors option[value=#{create_coauthor2.id}]").select_option
    fill_in 'abstract[corresponding_author_email]', with: 'example@gmail.com'
    fill_in 'abstract[keywords]', with: create_abstract.keywords
    fill_in 'abstract[body]', with: create_abstract.body
    fill_in 'abstract[references]', with: create_abstract.references

  end

  describe 'with valid data' do
    it 'is successful'  do
      find('input[type="submit"]').click
      abstract = Abstract.last
      participation = Participation.find_by(abstract_id:abstract.id)
      expect(Abstract.find_by(id: abstract.id)).not_to eq(nil)
      expect(current_path).to eq user_participation_abstract_path(create_user.id, participation.id, abstract.id)
    end
  end

  #check for has many users through participations
  #point of this test: even when user id and participation fields are not part
  #of new abstract form, because the association is set up correctly in models,
  #the expected data attributes and objects are still created
  #also test for set_kind method in participation
  describe 'upon create its associated participation object' do
    it 'has kind attribute with default value: other'  do
      find('input[type="submit"]').click
      abstract = Abstract.last
      participation = Participation.find_by(abstract_id:abstract.id)
      #create_participation
      expect(Abstract.find_by(id: abstract.id)).not_to eq(nil)
      #binding.pry
      expect(current_path).to eq user_participation_abstract_path(create_user.id, participation.id, abstract.id)
      expect(participation.kind).to eq("other")
    end
  end

  #also test for set_fee method in participation
  describe 'upon create its associated participation object' do
    it 'has fee attribute with default value: Please contact us for details.'  do
      find('input[type="submit"]').click
      abstract = Abstract.last
      participation = Participation.find_by(abstract_id:abstract.id)
      #create_participation
      expect(Abstract.find_by(id: abstract.id)).not_to eq(nil)
      #binding.pry
      expect(current_path).to eq user_participation_abstract_path(create_user.id, participation.id, abstract.id)
      expect(participation.fee).to eq("Please contact us for details.")
    end
  end


  describe 'upon create its associated participation object' do
    it "has user_id attribute value"  do
      find('input[type="submit"]').click
      abstract = Abstract.last
      participation = Participation.find_by(abstract_id:abstract.id)
      #create_participation
      expect(Abstract.find_by(id: abstract.id)).not_to eq(nil)
      #binding.pry
      expect(current_path).to eq user_participation_abstract_path(create_user.id, participation.id, abstract.id)
      expect(participation.user_id).to eq create_user.id
    end
  end
end
