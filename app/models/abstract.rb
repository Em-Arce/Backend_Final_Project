class Abstract < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations, dependent: :destroy

  #transform the input to desired format before save to db
  def format_params_field(name, params_fields, abstract)
    data =[]
    case name
    when :co_authors
      params_fields.reject(&:empty?).each do |params_field|
        data << params_field
      end
      abstract.update!(co_authors: data)
    when :references
      params_fields.split("\r\n").each do |params_field|
        data << params_field
      end
      abstract.update!(references: data)
      #binding.pry
    when :keywords
      params_fields.split(",").reject(&:empty?).each do |params_field|
        data << params_field
        #binding.pry
      end
      abstract.update!(keywords: data)
    else
      puts "Please edit abstract according to instructions."
    end
  end

  #get the co_authors without formatting
  def retrieve_co_authors(user_ids)
    @co_authors = []
    user_ids.each do |user_id|
      @co_authors << User.find(user_id)
    end
    #binding.pry
    return @co_authors  #array of user hashes
  end

  #format the co_authors name for view template
  def format_fullname(co_authors)
    data = co_authors.pluck(:first_name,:last_name)
    fullname_items = []
    fullname = ""
    first_name = ""
    last_name = ""
    data.each do |sub_array|
      first_name = sub_array[0]
      last_name  = sub_array[1].upcase
      fullname = first_name.concat(" #{last_name}")
      fullname_items << fullname
    end
    #binding.pry
    return fullname_items
  end

  def format_affiliation(co_authors)
    data = co_authors.pluck(:department, :university_institute_company, :city, :country)
    affiliation_items = []
    department = ""
    university_institute_company = ""
    city = ""
    country = ""
    affiliation = ""
    data.each do |sub_array|
      department = sub_array[0]
      university_institute_company = sub_array[1]
      city = sub_array[2]
      country = sub_array[3]
      affiliation = "#{department}, #{university_institute_company}, #{city}, #{country}"
      affiliation_items << affiliation
    end
    #binding.pry
    return affiliation_items
  end

  validates :title, :main_author, :co_authors, :corresponding_author_email,
    :keywords, :body, :references, presence: true

  #validate :check_keyword_delimiter
  def check_keyword_delimiter(keywords)
    if !keywords.include?(", ") #|| !self.keywords.include?(", ")
      #binding.pry
      errors.add(:keywords, "format is invalid.")
    end
  end
end
