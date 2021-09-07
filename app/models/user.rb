class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  TYPES = %w(Dr. Ms. Mr. Mrs. Prof. Sir Dame)
  validates :prefix, :inclusion => {:in => TYPES}
  validates :first_name,:last_name, :email, presence: true, on: :create

  PASSWORD_REQUIREMENTS = /\A #Start of string
    (?=.{6,}) # at least 6 characters long
    (?=.*\d)  # have at least one number
    (?=.*[a-z]) # have at least one lowercase letter
    (?=.*[A-Z]) # have at least one uppercase letter
    (?=.*[[:^alnum:]]) # have at least one symbol
  /x #End of string
  validates :password, format: PASSWORD_REQUIREMENTS
  validates :password_confirmation, format: PASSWORD_REQUIREMENTS
end
