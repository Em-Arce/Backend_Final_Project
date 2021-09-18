class AddCorrespondingAuthorEmailKeywordsAnd < ActiveRecord::Migration[6.1]
  def change
    add_column :abstracts,  :corresponding_author_email, :string,  null: false, default: ""
    add_column :abstracts,  :keywords, :jsonb #remove default so it will not show in form
    add_column :abstracts,  :references, :jsonb
  end
end
