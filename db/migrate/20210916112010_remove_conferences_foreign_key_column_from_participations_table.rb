class RemoveConferencesForeignKeyColumnFromParticipationsTable < ActiveRecord::Migration[6.1]
  def change
    remove_reference(:participations, :conference, null: false, foreign_key: true)
  end
end
