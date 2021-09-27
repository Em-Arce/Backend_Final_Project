require 'rails_helper'

RSpec.describe Abstract, type: :model do
  describe 'validations' do
    # Here we're using FactoryBot, but you could use anything
    subject { build(:abstract) }

    #check presence of fields on create
    it { expect(subject).to validate_presence_of(:title).on(:create) }
    it { expect(subject).to validate_presence_of(:main_author).on(:create) }
    it { expect(subject).to validate_presence_of(:co_authors).on(:create) }
    it { expect(subject).to validate_presence_of(:corresponding_author_email).on(:create) }
    it { expect(subject).to validate_presence_of(:keywords).on(:create) }
    it { expect(subject).to validate_presence_of(:references).on(:create) }

  end

  describe "co_authors attribute" do
    subject { build(:abstract) }
    it { expect(subject.co_authors).to be_a_kind_of(Array) }
    it { expect(subject.keywords).to have_at_least(1).items }
    it { expect(subject.keywords).to have_exactly(2).items }
  end

  describe "keywords attribute" do
    subject { build(:abstract) }
    it { expect(subject.keywords).to be_a_kind_of(Array) }
    it { expect(subject.keywords).to have_at_least(1).items }
    it { expect(subject.keywords).to have_at_most(5).items }
    it { expect(subject.keywords).to have_exactly(2).items }
  end

  describe "references attribute" do
    subject { build(:abstract) }
    it { expect(subject.references).to be_a_kind_of(Array) }
    it { expect(subject.references).to have_at_least(1).items }
    it { expect(subject.references).to have_exactly(2).items }
  end

  describe '#format_affiliation' do
    it 'returns expected affiliation data' do
      user = create(:user, prefix: "Ms.", position: "research_scientist")
      co_author1 = create(:user, prefix: "Dr.", position: "phd")
      co_author2 = create(:user, prefix: "Dr.", position: "faculty")
      data = []
      data << co_author1
      data << co_author2
      abstract = create(:abstract, main_author: "#{user.id}", co_authors: data)
      #binding.pry
      expect(abstract.format_affiliation(abstract.co_authors.map(&:symbolize_keys))).to eq(["#{co_author1.department}, #{co_author1.university_institute_company}, #{co_author1.city}, #{co_author1.country}", "#{co_author2.department}, #{co_author2.university_institute_company}, #{co_author2.city}, #{co_author2.country}"])
    end
  end
end



