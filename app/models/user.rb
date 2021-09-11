class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  TYPES = %w(Dr. Ms. Mr. Mrs. Prof. Sir Dame)
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
end
