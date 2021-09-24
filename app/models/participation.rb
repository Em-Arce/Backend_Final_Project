class Participation < ApplicationRecord
  #belongs_to :conference
  belongs_to :user
  belongs_to :abstract , optional: true


  KINDS = { regular_local_new_member: "Regular Local New Member",
            regular_local: "Regular Local",
            student_local: "Student Local",
            regular_foreign: "Regular Foreign",
            student_foreign: "Student Foreign",
            invited_speaker: "Invited Speaker",
            plenary_speaker: "Plenary Speaker",
            exhibitor: "Exhibitor",
            other: "Other"
  }

  enum kind: KINDS
  validates_inclusion_of :kind, in: HashWithIndifferentAccess.new(KINDS).keys
  validates :kind, :fee, presence: true, on: :create

  before_update :set_fee
  def set_fee
    kind = self.kind
    case kind
    when "regular_local_new_member" || "student_local"
      self.fee = "Php 500"
    when "regular_local"
      self.fee = "Php 1000"
    when "student_foreign"
      self.fee = "USD 50"
    when "regular_foreign"
      self.fee = "USD 100"
    when "invited_speaker" || "plenary_speaker" || "exhibitor"
      self.fee = "Your participation is not subject to conference fee."
    when "other"
      self.fee = "Please contact us for details."
    end
  end

  #if user has no existing abstracts, set participation kind to default
  before_create :set_default_kind
  def set_default_kind
    self.kind = "other"
    set_fee
  end
end
