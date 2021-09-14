class Participation < ApplicationRecord
  belongs_to :conference
  belongs_to :user
  belongs_to :abstract
end
