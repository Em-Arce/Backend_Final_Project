require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /" do
    it "should have status 200" do
      get "/"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /welcome" do
    it "should have status 200" do
      # user = create(:user)
      # sign_in user
      get static_pages_welcome_path
      expect(response).to have_http_status(200)
    end
  end
end
