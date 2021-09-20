class AddKindToParticipationsTable < ActiveRecord::Migration[6.1]
  def up
    add_column :participations, :kind, :string
    add_index :participations, :kind  #for query performance
  end

  def down
    remove_column :participations, :kind
  end
end
