class ApplicationMailer < ActionMailer::Base
  # обратный адрес всех писем по умолчанию
  default from: "alexmyror@gmail.com"
  layout 'mailer'
end
