class Conference < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations, dependent: :destroy

  enum kind: { online: "online", regular: "regular" },_prefix: :kind #Conference.kind_online/regular in rails c works
end
