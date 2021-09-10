class UserMailer < ApplicationMailer
  default :from => 'railsnewappnotificationaug2021@gmail.com'
  #def welcome_email(user)
  #  mail(to: user.email,
  #  subject: ‘Welcome to ISVSP 2022’,
  #  content_type: ‘text/plain’,
  #  body: "#{user.first_name}, welcome to ISVSP 2022! We look forward to see you at the conference!")
  #end

  def welcome_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Welcome to ISVSP 2022')
  end
end
