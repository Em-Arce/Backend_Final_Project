require 'rails_helper'

RSpec.describe "Abstracts", type: :request do
  describe "GET #index when admin is signed in" do
    it "should have status 200" do
      user_admin = create(:user, admin: "true", position: "research_scientist" )
      sign_in user_admin
      get abstracts_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #index when user who is not admin is signed in" do
    it "should have status 302" do
      user = create(:user, position: "research_scientist")
      sign_in user
      get abstracts_path
      expect(response).to have_http_status(302)
    end
  end

   describe "GET #new" do
    it "should have status 200" do
      user = create(:user, position: "research_scientist")
      sign_in user
      get new_user_abstract_path(user.id)
      expect(response).to have_http_status(200)
    end
  end
end
