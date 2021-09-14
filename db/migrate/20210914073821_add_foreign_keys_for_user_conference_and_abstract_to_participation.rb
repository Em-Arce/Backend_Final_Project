class AddForeignKeysForUserConferenceAndAbstractToParticipation < ActiveRecord::Migration[6.1]
  def change
    add_reference :participations, :conference, null: false, foreign_key: true
    add_reference :participations, :abstract, null: false, foreign_key: true
  end
end
