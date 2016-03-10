class RecoveryEmail < ApplicationMailer

  def send_email(user, hash)
    @user = user
    @hash = hash
    mail(to: user.email, subject: 'Healthy Life Password Recovery')
  end

end
