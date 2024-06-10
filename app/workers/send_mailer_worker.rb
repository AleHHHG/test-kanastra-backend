# frozen_string_literal: true

require 'sneakers'

class SendMailerWorker
  include Sneakers::Worker

  from_queue 'send.email', prefetch: 3, threads: 3

  def work(msg)
    msg = JSON.parse(msg).deep_symbolize_keys
    "#{msg[:mailer]}".constantize.send(msg[:mail_method], *msg[:args]).deliver_now
    ack!
  end
end
