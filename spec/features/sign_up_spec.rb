require "rails_helper"

RSpec.describe "Sign up a new user", type: :feature do
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:email) { Faker::Internet.unique.email }
  let(:password) { Faker::Internet.password(min_length: 6, max_length: 128,
          mix_case: true, special_characters: true) }

  before do
    visit root_path
    find('a[href="/users/sign_up"]', text: 'Sign up').click
    visit new_user_registration_path

    page.find('#user_prefix option[value="Prof."]').select_option
    fill_in "user[first_name]", with: first_name
    fill_in "user[last_name]", with: last_name
    fill_in "user[email]", with: email
    fill_in "user[password]", with: password
    fill_in "user[password_confirmation]", with: password
  end

  it "is successful with valid data" do
    click_button 'Sign up'
    expect(current_path).to eq static_pages_welcome_path
    expect(page).to have_content("Welcome! You have signed up successfully.")
    user = User.order('id').last
    user_count = User.count
    expect(user_count).to eq(1)
    expect(user.first_name).to eq(first_name)
    expect(user.email).to eq(email)
  end

  describe "fails when sign up field is invalid" do
    it "first name is blank" do
      fill_in "user[first_name]", with: ''
      click_button 'Sign up'
      expect(page).to have_content("First name can't be blank")
      expect(current_path).to eq '/users'
      user = User.order('id').last
      user_count = User.count
      expect(user_count).to eq(0)
    end

    it "last name is blank" do
      fill_in "user[last_name]", with: ''
      click_button 'Sign up'
      expect(page).to have_content("Last name can't be blank")
      expect(current_path).to eq '/users'
      user = User.order('id').last
      user_count = User.count
      expect(user_count).to eq(0)
    end

    it "email is blank" do
      fill_in "user[email]", with: ''
      click_button 'Sign up'
      expect(page).to have_content("Email can't be blank")
      expect(current_path).to eq '/users'
      user = User.order('id').last
      user_count = User.count
      expect(user_count).to eq(0)
    end

    it "invalid email format is given" do
      fill_in "user[email]", with: 'test.test.com'
      click_button 'Sign up'
      expect(page).to have_content("Email is invalid")
      expect(current_path).to eq '/users'
      user = User.order('id').last
      user_count = User.count
      expect(user_count).to eq(0)
    end

    it "email is already used for sign up" do
      click_button 'Sign up'
      expect(current_path).to eq static_pages_welcome_path
      expect(page).to have_content("Welcome! You have signed up successfully.")
      click_link 'Logout'
      expect(current_path).to eq root_path
      find('a[href="/users/sign_up"]', text: 'Sign up').click
      visit new_user_registration_path
      page.find('#user_prefix option[value="Prof."]').select_option
      fill_in "user[first_name]", with: first_name
      fill_in "user[last_name]", with: last_name
      fill_in "user[email]", with: email
      fill_in "user[password]", with: password
      fill_in "user[password_confirmation]", with: password
      click_button 'Sign up'
      expect(page).to have_content("Email has already been taken")
      expect(current_path).to eq '/users'
      user = User.count
      expect(user).to eq(1)
    end

    it "password is blank" do
      fill_in "user[password]", with: ''
      click_button 'Sign up'
      expect(page).to have_content("Password can't be blank")
      expect(current_path).to eq '/users'
      user = User.order('id').last
      user_count = User.count
      expect(user_count).to eq(0)
    end

    it "password confirmation is blank" do
      fill_in "user[password_confirmation]", with: ''
      click_button 'Sign up'
      expect(page).to have_content("Password confirmation can't be blank")
      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(current_path).to eq '/users'
      user = User.order('id').last
      user_count = User.count
      expect(user_count).to eq(0)
    end

    it "password and password confirmation fields are different" do
      fill_in 'user_password_confirmation', with: 'abcd1234'
      click_button 'Sign up'
      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(current_path).to eq '/users'
      user = User.count
      expect(user).to eq(0)
    end

    it "password is too short" do
      fill_in "user[password]", with: 'Abc2!'
      click_button 'Sign up'
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(current_path).to eq '/users'
      user = User.order('id').last
      user_count = User.count
      expect(user_count).to eq(0)
    end

    it "password does not have at least one lower case letter" do
      fill_in "user[password]", with: 'PASSWORD18?'
      click_button 'Sign up'
      expect(current_path).to eq '/users'
      user = User.order('id').last
      user_count = User.count
      expect(user_count).to eq(0)
    end

    it "password does not have at least one upper case letter" do
      fill_in "user[password]", with: 'password18?'
      click_button 'Sign up'
      expect(current_path).to eq '/users'
      user = User.order('id').last
      user_count = User.count
      expect(user_count).to eq(0)
    end

    it "password does not have at least one digit" do
      fill_in "user[password]", with: 'Password?'
      click_button 'Sign up'
      expect(current_path).to eq '/users'
      user = User.order('id').last
      user_count = User.count
      expect(user_count).to eq(0)
    end

    it "password does not have at least one symbol" do
      fill_in "user[password]", with: 'Password1'
      click_button 'Sign up'
      expect(current_path).to eq '/users'
      user = User.order('id').last
      user_count = User.count
      expect(user_count).to eq(0)
    end
  end
end
