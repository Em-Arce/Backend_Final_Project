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
end
