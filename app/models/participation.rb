class Participation < ApplicationRecord
  #belongs_to :conference
  belongs_to :user
  belongs_to :abstract

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

  def set_fee(kind)
    case kind
    when

    end
  end
end
