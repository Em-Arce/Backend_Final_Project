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

  describe "GET #edit" do
    it "should have status 200" do
      user = create(:user, position: "research_scientist")
      abstract = create(:abstract)
      participation = create(:participation, user_id: user.id, abstract_id: abstract.id)
      sign_in user
      get edit_user_abstract_path(user.id, abstract.id)
      expect(response).to have_http_status(200)
    end
  end

    describe "GET #show" do
    it "should have status 200" do
      user = create(:user, position: "research_scientist")
      coauthor1 = create(:user, prefix: "Dr.", position: "phd")
      coauthor2 = create(:user, prefix: "Dr.", position: "faculty")
      abstract = create(:abstract, main_author: user.id,
        co_authors: [ coauthor1.id.to_s, coauthor2.id.to_s ],
        keywords: "key1, key2", references: "\r\n [1] ref1.\r\n [2] ref2.\r\n" )

      participation = create(:participation, user_id: user.id, abstract_id: abstract.id)
      sign_in user
      get user_participation_abstract_path(user.id, participation.id, abstract.id)
      expect(response).to have_http_status(200)
    end
  end

end
