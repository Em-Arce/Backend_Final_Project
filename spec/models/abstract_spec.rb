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


  describe '#format_params_field for co_authors attribute' do
    let(:create_user) { create(:user, prefix: "Ms.", position: "research_scientist") }
    let(:create_coauthor1) { create(:user, prefix: "Dr.", position: "phd") }
    let(:create_coauthor2) { create(:user, prefix: "Dr.", position: "faculty") }
    let(:create_abstract) { create(:abstract, main_author: create_user.id,
      co_authors: [ "", create_coauthor1.id.to_s, create_coauthor2.id.to_s ]) }

    before do
      create_user
      create_coauthor1
      create_coauthor2
      create_abstract
      #binding.pry
    end

    it 'formats and updates co_authors' do
      expect(create_abstract.format_params_field(:co_authors, create_abstract.co_authors, create_abstract)).to eq(true)
    end
  end

  describe '#format_params_field for references attribute' do
    let(:create_user) { create(:user, prefix: "Ms.", position: "research_scientist") }
    let(:create_coauthor1) { create(:user, prefix: "Dr.", position: "phd") }
    let(:create_coauthor2) { create(:user, prefix: "Dr.", position: "faculty") }
    let(:create_abstract) { create(:abstract, main_author: create_user.id,
      co_authors: [ "", create_coauthor1.id.to_s, create_coauthor2.id.to_s ],
      references: ["\r\n", "[1] key1.\r\n", "[2] key2.\r\n"]) }

    before do
      create_user
      create_coauthor1
      create_coauthor2
      create_abstract
      #binding.pry
    end

    it 'formats and updates references' do
      expect(create_abstract.format_params_field(:references, create_abstract.references, create_abstract)).to eq(true)
    end
  end

  describe '#format_params_field for keywords attribute' do
    let(:create_user) { create(:user, prefix: "Ms.", position: "research_scientist") }
    let(:create_coauthor1) { create(:user, prefix: "Dr.", position: "phd") }
    let(:create_coauthor2) { create(:user, prefix: "Dr.", position: "faculty") }
    let(:create_abstract) { create(:abstract, main_author: create_user.id,
      co_authors: [ "", create_coauthor1.id.to_s, create_coauthor2.id.to_s ],
      keywords: ["", "key1", "key2"]) }

    before do
      create_user
      create_coauthor1
      create_coauthor2
      create_abstract
      #binding.pry
    end

    it 'formats and updates keywords' do
      expect(create_abstract.format_params_field(:keywords, create_abstract.keywords, create_abstract)).to eq(true)
    end
  end


  describe '#retrieve_co_authors' do
    it 'queries from User model and returns collection of co authors' do
      user = create(:user, prefix: "Ms.", position: "research_scientist")
      co_author1 = create(:user, prefix: "Dr.", position: "phd")
      co_author2 = create(:user, prefix: "Dr.", position: "faculty")
      data = []
      data << co_author1.id
      data << co_author2.id
      abstract = create(:abstract, main_author: "#{user.id}", co_authors: data)
      #binding.pry
      expect(abstract.retrieve_co_authors(abstract.co_authors)).to eq([co_author1, co_author2])
    end
  end

  describe '#format_fullname' do
    it 'returns expected fullname data' do
      user = create(:user, prefix: "Ms.", position: "research_scientist")
      co_author1 = create(:user, prefix: "Dr.", position: "phd")
      co_author2 = create(:user, prefix: "Dr.", position: "faculty")
      data = []
      data << co_author1
      data << co_author2
      abstract = create(:abstract, main_author: "#{user.id}", co_authors: data)
      #binding.pry
      expect(abstract.format_fullname(abstract.co_authors.map(&:symbolize_keys))).to eq(["#{co_author1.first_name} #{co_author1.last_name.upcase}", "#{co_author2.first_name} #{co_author2.last_name.upcase}"])
    end
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



