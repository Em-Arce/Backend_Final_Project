class RemoveForeignKeyColumnFromAbstractsTable < ActiveRecord::Migration[6.1]
  def change
    remove_reference(:abstracts, :participation, null: false, foreign_key: true)
  end
end
