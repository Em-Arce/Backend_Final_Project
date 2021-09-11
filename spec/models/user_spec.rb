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
  end

end
