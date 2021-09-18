# Preview all emails at http://localhost:3000/rails/mailers/abstract
class AbstractMailerPreview < ActionMailer::Preview
  def abstract_submission
    abstract = Abstract.last
    user = abstract.main_author
    AbstractMailer.abstract_submission(user, abstract)
  end
end
