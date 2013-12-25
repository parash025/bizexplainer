class UserMailer < ActionMailer::Base
  default from: "parash025@gmail.com"


  def registration_confirmation
    mail to: "parasht@gmail.com", from: "parash025@gmail.com", subject: "BizExplainer", body: "Thanks for registering!!"
  end

end
