class UserMailer < ActionMailer::Base
  default from: "parash025@gmail.com"


  def registration_confirmation (user)
    @user = user
    @url = 'http://bizexplainer.com/login'
    mail to: @user.email, subject: "BizExplainer"
  end

end
