require "rails_helper"

RSpec.describe "Shows an Abstract", type: :feature do
  let(:create_user) { create(:user, prefix: "Ms.", position: "research_scientist") }
  let(:create_coauthor1) { create(:user, prefix: "Dr.", position: "phd") }
  let(:create_coauthor2) { create(:user, prefix: "Dr.", position: "faculty") }
  let(:create_abstract) { create(:abstract, main_author: create_user.id,
      co_authors: [ create_coauthor1.id.to_s, create_coauthor2.id.to_s ],
      keywords: "key1, key2", references: "\r\n [1] ref1.\r\n [2] ref2.\r\n" ) }
  let(:create_participation) { create(:participation, user_id: create_user.id,
    abstract_id: create_abstract.id ) }

  before do
    #binding.pry
    create_coauthor1
    create_coauthor2
    login_as(create_user, scope: :user)
    create_abstract
    create_participation
  end

  it 'after create'  do
    visit user_participation_abstract_path(create_user.id, create_participation.id, create_abstract.id)
    expect(current_path).to eq user_participation_abstract_path(create_user.id, create_participation.id, create_abstract.id)
    expect(page).to have_content("#{create_abstract.title}")
  end

  it 'from Conference Profile Page'  do
    abstract = Abstract.last
    participation = Participation.last
    visit user_participation_profile_path(create_user.id, participation.id)
    expect(page).to have_content("My Conference Profile")
    click_link "#{abstract.title}"
    expect(current_path).to eq user_participation_abstract_path(create_user.id, participation.id, abstract.id)
    expect(page).to have_content("#{create_abstract.title}")
  end

  it 'goes to conference profile page when My Conference Details link is clicked '  do
    abstract = Abstract.all.last
    participation = Participation.last
    visit user_participation_abstract_path(create_user.id, participation.id, abstract.id)
    expect(current_path).to eq user_participation_abstract_path(create_user.id, participation.id, abstract.id)
    expect(page).to have_content("#{create_abstract.title}")
    click_link 'My Conference Details'
    expect(current_path).to eq user_participation_profile_path(create_user.id, participation.id)
    expect(page).to have_content("My Conference Profile")
  end
end
