require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET #index when admin is signed in" do
    it "should have status 200" do
      user_admin = create(:user, admin: "true")
      sign_in user_admin
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #index when user who is not admin is signed in" do
    it "should have status 302" do
      user = create(:user)
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
      abstract = create(:abstract)
      participation = build(:participation)
      participation.update!(user_id: user.id, abstract_id: abstract.id)
      sign_in user
      get edit_user_participation_path(user.id, participation.id)
      expect(response).to have_http_status(200)
    end
  end
end
