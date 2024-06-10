# frozen_string_literal: true

class MailerService
  class << self
    def publish(mailer, mail_method, *args)
      payload = { mailer: mailer.to_s, mail_method: mail_method.to_s, args: args }
      SendEmailEvent.new(payload).publish!
    end
  end
end
