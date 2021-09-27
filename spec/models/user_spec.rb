require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    # Here we're using FactoryBot, but you could use anything
    subject { build(:user) }

    #check if prefix has any of the values in TYPE enum
    it { expect(subject).to validate_inclusion_of(:prefix).in_array(%w(Dr. Ms. Mr. Mrs. Prof. Sir Dame) ) }

    #check presence of fields on create
    it { expect(subject).to validate_presence_of(:prefix).on(:create) }
    it { expect(subject).to validate_presence_of(:first_name).on(:create) }
    it { expect(subject).to validate_presence_of(:last_name).on(:create) }
    it { expect(subject).to validate_presence_of(:email).on(:create) }
    it { expect(subject).to validate_presence_of(:password).on(:create) }
    it { expect(subject).to validate_presence_of(:password_confirmation).on(:create) }

    #check if position has any of the values in Positions enum
    #source: https://github.com/thoughtbot/shoulda-matchers/blob/master/lib/shoulda/matchers/active_record/define_enum_for_matcher.rb
    it do
        should define_enum_for(:position).
          with_values(
            research_scientist: "Research Scientist",
              professor: "Professor",
              phd: "PhD",
              faculty: "Faculty",
              doctoral_student: "Doctoral Student",
              masteral_student: "Masteral Student",
              college_student: "College Student",
              highschool_student: "High School Student",
              other: "Other"
          ).
          backed_by_column_of_type(:string)
    end

    #check presence of fields on update
    it { expect(subject).to validate_presence_of(:position).on(:update) }
    it { expect(subject).to validate_presence_of(:university_institute_company).on(:update) }
    it { expect(subject).to validate_presence_of(:department).on(:update) }
    it { expect(subject).to validate_presence_of(:contact_number).on(:update) }
    it { expect(subject).to validate_presence_of(:city).on(:update) }
    it { expect(subject).to validate_presence_of(:country).on(:update) }
  end

  describe '#get_fullname' do
    it 'returns user full_name with prefix' do
      user = create(:user, position: "research_scientist")
      #stubs allow an object to respond to method call with some value. http://rubyblog.pro/2017/10/rspec-difference-between-mocks-and-stubs
      expect(user.get_fullname).to eq("#{user.prefix} #{user.first_name} #{user.last_name} #{user.suffix}")
    end
  end
end
