class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  TYPES = %w(Dr. Ms. Mr. Mrs. Prof. Sir Dame)
  validates :prefix, :inclusion => {:in => TYPES}
end
