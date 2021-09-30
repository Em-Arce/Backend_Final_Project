require "rails_helper"

RSpec.describe "Edits a Participation", type: :feature do
 let(:create_user) { create(:user, prefix: "Ms.", position: "research_scientist") }
  let(:create_coauthor1) { create(:user, prefix: "Dr.", position: "phd") }
  let(:create_coauthor2) { create(:user, prefix: "Dr.", position: "faculty") }
  let(:create_abstract) { create(:abstract, main_author: create_user.id,
      co_authors: [ create_coauthor1.id.to_s, create_coauthor2.id.to_s ],
      keywords: "key1, key2", references: "\r\n [1] ref1.\r\n [2] ref2.\r\n" ) }
  let(:create_participation) { create(:participation, user_id: create_user.id,
    abstract_id: create_abstract.id ) }
  let(:create_abstract2) { create(:abstract, main_author: create_user.id,
      co_authors: [ create_coauthor1.id.to_s, create_coauthor2.id.to_s ],
      keywords: "key1, key2", references: "\r\n [1] ref1.\r\n [2] ref2.\r\n" ) }
  let(:create_participation2) { create(:participation, user_id: create_user.id,
    abstract_id: create_abstract2.id ) }

  before do
    create_coauthor1
    create_coauthor2
    login_as(create_user, scope: :user)
    create_abstract
    create_participation
    visit user_participation_abstract_path(create_user.id, create_participation.id, create_abstract.id)
    abstract = Abstract.last
    participation = Participation.find_by(abstract_id:abstract.id)
    expect(current_path).to eq user_participation_abstract_path(create_user.id, participation.id, abstract.id)
    click_link 'My Conference Details'
    expect(current_path).to eq user_participation_profile_path(create_user.id, participation.id)
    expect(page).to have_content("My Conference Profile")
    expect(page).to have_content("My ISVSP 2022 Participation")
    expect(page).to have_content("My Abstracts: #{Abstract.count}")
    find("a[href='/users/#{create_user.id}/participations/#{create_participation.id}/edit']").click
  end


  describe 'with valid data' do
    it 'is successful'  do
      abstract = Abstract.last
      participation = Participation.find_by(abstract_id:abstract.id)
      expect(current_path).to eq edit_user_participation_path(create_user.id, participation.id)
      expect(participation.kind).to eq "other"
      page.find("#participation_prefix option[value='Ms.']").select_option
      fill_in 'participation[first_name]', with: "#{create_user.first_name}"
      fill_in 'participation[last_name]', with: "#{create_user.last_name}"
      fill_in 'participation[suffix]', with: ""
      fill_in 'participation[email]', with: "#{create_user.email}"
      page.find("#participation_position option[value='Doctoral Student']").select_option
      fill_in 'participation[university_institute_company]', with: "Chu chu University"
      fill_in 'participation[department]', with: "Chu chu Department"
      fill_in 'participation[city]', with: "Manila"
      fill_in 'participation[country]', with: "Philippines"
      fill_in 'participation[contact_number]', with: "+63 9178231275"
      page.find("#participation_kind option[value='Regular Foreign']").select_option
      find('input[type="submit"]').click
      abstract = Abstract.last
      participation = Participation.find_by(abstract_id:abstract.id)
      user = User.find_by(id: create_user.id)
      expect(current_path).to eq user_participation_profile_path(create_user.id, participation.id)
      expect(participation.kind).to eq "regular_foreign"
      expect(participation.fee).to eq("USD 100")
    end

    it 'with corresponding user attributes updated'  do
      abstract = Abstract.last
      participation = Participation.find_by(abstract_id:abstract.id)
      expect(current_path).to eq edit_user_participation_path(create_user.id, participation.id)
      expect(participation.kind).to eq "other"
      page.find("#participation_prefix option[value='Ms.']").select_option
      fill_in 'participation[first_name]', with: "#{create_user.first_name}"
      fill_in 'participation[last_name]', with: "#{create_user.last_name}"
      fill_in 'participation[suffix]', with: ""
      fill_in 'participation[email]', with: "#{create_user.email}"
      page.find("#participation_position option[value='Doctoral Student']").select_option
      fill_in 'participation[university_institute_company]', with: "Chu chu University"
      fill_in 'participation[department]', with: "Chu chu Department"
      fill_in 'participation[city]', with: "Manila"
      fill_in 'participation[country]', with: "Philippines"
      fill_in 'participation[contact_number]', with: "+63 9178231275"
      page.find("#participation_kind option[value='Regular Foreign']").select_option
      find('input[type="submit"]').click
      abstract = Abstract.last
      participation = Participation.find_by(abstract_id:abstract.id)
      user = User.find_by(id: create_user.id)
      expect(current_path).to eq user_participation_profile_path(create_user.id, participation.id)
      expect(user.position).to eq("doctoral_student")
      expect(user.university_institute_company).to eq("Chu chu University")
      expect(user.department).to eq("Chu chu Department")
      expect(user.city).to eq("Manila")
      expect(user.country).to eq("Philippines")
      expect(user.contact_number).to eq("+63 9178231275")
    end

    #test for cascade to all participations the change in one
    it 'with all other participations attributes updated as well'  do
      create_abstract2
      create_participation2
      expect(current_path).to eq edit_user_participation_path(create_user.id, create_participation.id)
      expect(create_participation.kind).to eq "other"
      page.find("#participation_prefix option[value='Ms.']").select_option
      fill_in 'participation[first_name]', with: "#{create_user.first_name}"
      fill_in 'participation[last_name]', with: "#{create_user.last_name}"
      fill_in 'participation[suffix]', with: ""
      fill_in 'participation[email]', with: "#{create_user.email}"
      page.find("#participation_position option[value='Doctoral Student']").select_option
      fill_in 'participation[university_institute_company]', with: "Chu chu University"
      fill_in 'participation[department]', with: "Chu chu Department"
      fill_in 'participation[city]', with: "Manila"
      fill_in 'participation[country]', with: "Philippines"
      fill_in 'participation[contact_number]', with: "+63 9178231275"
      page.find("#participation_kind option[value='Regular Foreign']").select_option
      find('input[type="submit"]').click
      expect(current_path).to eq user_participation_profile_path(create_user.id, create_participation.id)
      expect(Participation.first.kind).to eq "regular_foreign"
      expect(Participation.first.fee).to eq("USD 100")
      expect(Participation.last.kind).to eq "regular_foreign"
      expect(Participation.last.fee).to eq("USD 100")
    end
  end

  describe 'with invalid data:' do
    it 'blank first_name fails'  do
      abstract = Abstract.last
      participation = Participation.find_by(abstract_id:abstract.id)
      expect(current_path).to eq edit_user_participation_path(create_user.id, participation.id)
      expect(participation.kind).to eq "other"
      page.find("#participation_prefix option[value='Ms.']").select_option
      fill_in 'participation[first_name]', with: ""
      fill_in 'participation[last_name]', with: "#{create_user.last_name}"
      fill_in 'participation[suffix]', with: ""
      fill_in 'participation[email]', with: "#{create_user.email}"
      page.find("#participation_position option[value='Doctoral Student']").select_option
      fill_in 'participation[university_institute_company]', with: "Chu chu University"
      fill_in 'participation[department]', with: "Chu chu Department"
      fill_in 'participation[city]', with: "Manila"
      fill_in 'participation[country]', with: "Philippines"
      fill_in 'participation[contact_number]', with: "+63 9178231275"
      page.find("#participation_kind option[value='Regular Foreign']").select_option
      find('input[type="submit"]').click
      abstract = Abstract.last
      participation = Participation.find_by(abstract_id:abstract.id)
      user = User.find_by(id: create_user.id)
      expect(page).to have_content("We're sorry, but something went wrong.")
    end
  end
end
