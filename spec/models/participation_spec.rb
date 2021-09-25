require 'rails_helper'

RSpec.describe Participation, type: :model do
  describe 'validations' do
    # Here we're using FactoryBot, but you could use anything
    subject { build(:participation) }

    #check presence of fields on create
    #it { expect(subject).to validate_presence_of(:kind).on(:create) }
    #it { expect(subject).to validate_presence_of(:fee).on(:create) }

    it do
        should define_enum_for(:kind).
          with_values(
            regular_local_new_member: "Regular Local New Member",
            regular_local: "Regular Local",
            student_local: "Student Local",
            regular_foreign: "Regular Foreign",
            student_foreign: "Student Foreign",
            invited_speaker: "Invited Speaker",
            plenary_speaker: "Plenary Speaker",
            exhibitor: "Exhibitor",
            other: "Other"
          ).
          backed_by_column_of_type(:string)
    end
  end
end
