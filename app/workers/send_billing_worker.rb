# frozen_string_literal: true

require 'sneakers'

class SendBillingWorker
  include Sneakers::Worker

  from_queue 'send.billing', prefetch: 3, threads: 3

  def work(msg)
    msg = JSON.parse(msg).deep_symbolize_keys
    SendBillingService.process(msg)
    ack!
  end
end
