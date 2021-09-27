require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET #index when admin is signed in" do
    it "should have status 200" do
      user_admin = create(:user, admin: "true", position: "research_scientist")
      sign_in user_admin
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #index when user who is not admin is signed in" do
    it "should have status 302" do
      user = create(:user, position: "research_scientist")
      sign_in user
      get users_path
      expect(response).to have_http_status(302)
    end
  end

  #nested resource due to association
  describe "GET participations#profile" do
    it "should have status 200" do
      user = create(:user, position: "research_scientist")
      abstract = create(:abstract)
      #participation = user.abstracts.last
      participation = build(:participation)
      participation.update!(user_id: user.id, abstract_id: abstract.id)
      sign_in user
      get user_participation_profile_path(user.id, participation.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET participations#edit" do
    it "should have status 200" do
      user = create(:user, position: "research_scientist")
      #another way of building data for has many through before the factory bot had associations
      abstract = create(:abstract)
      participation = build(:participation)
      participation.update!(user_id: user.id, abstract_id: abstract.id)

      #uncomment below and use line 40 to correct error: ActiveRecord::RecordInvalid:
            #Validation failed: Kind is not included in the list, Kind can't be blank, Fee can't be blank
      #abstract = user.abstracts.last
      #participation = user.participations.all.find_by(abstract_id: abstract.id)

      sign_in user
      get edit_user_participation_path(user.id, participation.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET abstracts#show" do
    it "should have status 200" do
      user = create(:user, position: "research_scientist")
      co_author1 = create(:user, position: "phd" )
      co_author2 = create(:user, position: "phd" )
      abstract = create(:abstract, co_authors: ["#{co_author1.id}","#{co_author2.id}"] )
      participation = build(:participation)
      participation.update!(user_id: user.id, abstract_id: abstract.id)
      sign_in user
      get user_participation_abstract_path(user.id, participation.id, abstract.id)
      expect(response).to have_http_status(200)
    end
  end
end
