class Abstract < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations, dependent: :destroy

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
        #binding.pry
      end
      abstract.update!(references: data)
    when :keywords
      params_fields.split(",").reject(&:empty?).each do |params_field|
        data << params_field
        #binding.pry
      end
      abstract.update!(keywords: data)
    else
      puts "Please edit your abstract."
    end
  end

  def retrieve_co_authors(user_ids)
    @co_authors = []
    user_ids.each do |user_id|
      @co_authors << User.find(user_id)
    end
    #binding.pry
    return @co_authors
  end

  def get_fullname(co_authors)
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

end
