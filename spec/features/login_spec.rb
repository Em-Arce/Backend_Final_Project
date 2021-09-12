require "rails_helper"

RSpec.describe "Log in a user", type: :feature do
  shared_examples "who is admin" do
    it "successfully" do
      expect(page).to have_content("Signed in successfully")
    end
  end

  shared_examples "user with invalid data" do
    it "fails" do
      expect(page).not_to have_content("Signed in successfully")
    end
  end

  context 'when user who is admin logs in with valid data' do
    let(:create_user_admin) { create(:user, admin: 'true') }

    before do
      create_user_admin
      visit root_path
      find('a[href="/users/sign_in"]').click

      fill_in 'user[email]', with: create_user_admin.email
      fill_in 'user[password]', with: create_user_admin.password
      find('input[type="submit"]').click
    end

      include_examples 'who is admin'
  end

  context 'when user who is not an admin logs in with valid data' do
    let(:create_user) { create(:user) }

    before do
      create_user
      visit root_path
      find('a[href="/users/sign_in"]').click

      fill_in 'user[email]', with: create_user.email
      fill_in 'user[password]', with: create_user.password
      find('input[type="submit"]').click
    end

      it_behaves_like 'who is admin'
  end

  context 'when email field is blank' do
    let(:create_user) { create(:user ) }

    before do
      create_user
      visit root_path
      find('a[href="/users/sign_in"]').click

      fill_in 'user[email]', with: ""
      fill_in 'user[password]', with: create_user.password
      find('input[type="submit"]').click
    end

      include_examples "user with invalid data"
  end

  context 'when password field is blank' do
    let(:create_user) { create(:user ) }

    before do
      create_user
      visit root_path
      find('a[href="/users/sign_in"]').click

      fill_in 'user[email]', with: create_user.email
      fill_in 'user[password]', with: ""
      find('input[type="submit"]').click
    end

      include_examples "user with invalid data"
  end

  context 'when password and email fields are blank' do
    let(:create_user) { create(:user ) }

    before do
      create_user
      visit root_path
      find('a[href="/users/sign_in"]').click

      fill_in 'user[email]', with: ""
      fill_in 'user[password]', with: ""
      find('input[type="submit"]').click
    end

      include_examples "user with invalid data"
  end
end

RSpec.describe "Login form buttons check", type: :feature do
    it 'for sign up' do
        visit root_path
        click_link 'Login'
        click_link 'Sign up'
        expect(current_path).to eq '/users/sign_up'
    end

    it 'for forgot password' do
        visit root_path
        click_link 'Login'
        click_link 'Forgot your password?'
        expect(page).to have_content('Forgot your password?')
        expect(current_path).to eq '/users/password/new'
    end
end
