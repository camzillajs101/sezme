class TestMailer < ApplicationMailer
  def hello
    mail(to: "camilomason0@gmail.com", subject: 'Welcome to My Awesome Site')
  end
end
