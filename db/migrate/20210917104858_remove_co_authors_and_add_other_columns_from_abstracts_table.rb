class RemoveCoAuthorsAndAddOtherColumnsFromAbstractsTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :abstracts, :co_authors, :jsonb, default: "{}", null: false
    add_column :abstracts, :co_authors, :jsonb, default: "{}"
    add_index :abstracts, :co_authors, using: :gin
    add_column :abstracts, :co_authors1, :text, array: true, default: []
  end
end
