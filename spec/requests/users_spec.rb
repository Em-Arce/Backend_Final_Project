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

  describe "GET #static_pages_welcome when user who is not admin is signed in" do
    it "should have status 302" do
      user = create(:user)
      sign_in user
      get users_path
      expect(response).to have_http_status(302)
    end
  end
end
