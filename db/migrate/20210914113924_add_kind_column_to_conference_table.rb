class AddKindColumnToConferenceTable < ActiveRecord::Migration[6.1]
  def up
    add_column :conferences, :kind, :string
    add_index :conferences, :kind  #for query performance
  end

  def down
    remove_column :conferences, :kind
  end
end
