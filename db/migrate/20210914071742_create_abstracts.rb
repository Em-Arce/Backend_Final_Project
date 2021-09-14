class CreateAbstracts < ActiveRecord::Migration[6.1]
  def change
    create_table :abstracts do |t|
      t.string :title
      t.string :main_author
      t.string :co_authors
      t.text :body
      t.references :participation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
