class AbstractMailer < ApplicationMailer
  default :from => 'railsnewappnotificationaug2021@gmail.com'
  def abstract_submission(user, abstract)
    @user = User.find(user)
    @abstract = abstract
    mail( :to => @user.email,
    :subject => 'Abstract Submission')
  end
end
