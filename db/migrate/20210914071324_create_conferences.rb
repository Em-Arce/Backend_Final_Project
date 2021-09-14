class CreateConferences < ActiveRecord::Migration[6.1]
  def change
    create_table :conferences do |t|
      t.string :name
      t.string :string
      t.integer :year
      t.string :theme
      t.string :venue

      t.timestamps
    end
  end
end
