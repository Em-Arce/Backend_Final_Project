class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  TYPES = %w(Dr. Ms. Mr. Mrs. Prof. Sir Dame).freeze
  validates :prefix, :inclusion => {:in => TYPES}
  validates :prefix,:first_name,:last_name, :email, :password, :password_confirmation,
            presence: true, on: :create

  PASSWORD_FORMAT = /\A #Start of string
    (?=.{6,}) # at least 6 characters
    (?=.*\d)  # at least one number
    (?=.*[a-z]) # at least one lowercase letter
    (?=.*[A-Z]) # at least one uppercase letter
    (?=.*[[:^alnum:]]) # have at least one symbol
  /x #End of string

  #check the password complexity on create
  validates :password, length: { in: Devise.password_length }, format: PASSWORD_FORMAT,
            confirmation: true, on: :create

  validates :password_confirmation, format: PASSWORD_FORMAT, on: :create

  #callback for sending email notification
  after_create :send_email

  def send_email
    UserMailer.welcome_email(self).deliver_later
  end

  has_many :participations, dependent: :destroy
  #has_many :conferences, through: :participations, dependent: :destroy
  has_many :abstracts, through: :participations, dependent: :destroy

  accepts_nested_attributes_for :participations

  validates :prefix,:first_name,:last_name, :email, :position,
            :university_institute_company, :department, :contact_number,
            presence: true, on: :update

  def participations_attributes=(participations_attributes)
    participations_attributes.values.each do |participation_attribute|
      participation = Participation.find_or_create_by(participation_attribute)
      self.participations << participation
    end
  end

  def co_author_properties
    "#{prefix} #{first_name} #{last_name} #{suffix}"
  end

  POSITIONS = { research_scientist: "Research Scientist",
                professor: "Professor",
                phd: "PhD",
                faculty: "Faculty",
                doctoral_student: "Doctoral Student",
                masteral_student: "Masteral Student",
                college_student: "College Student",
                highschool_student: "High School Student",
                other: "Other"
  }
  #this saves sa nil in db :((
  # POSITIONS = { reseach_scientist: 0,
  #               professor: 1,
  #                  phd: 2,
  #                  faculty: 3,
  #                  doctoral_student: 4,
  #                  masteral_student: 5,
  #                  college_student: 6,
  #                  highschool_student: 7,
  #                  other: 8
  #                   }
  enum position: POSITIONS
end
