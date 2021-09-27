class AbstractMailer < ApplicationMailer
  default :from => 'railsnewappnotificationaug2021@gmail.com'
  def abstract_submission(user, abstract)
    @user = User.find(user)
    @abstract = abstract
    @participation = @user.participations.find_by(abstract_id: @abstract.id)
    mail( :to => @user.email,
    :subject => 'Abstract Submission')
  end
end
