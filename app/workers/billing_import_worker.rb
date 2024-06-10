# frozen_string_literal: true

require 'sneakers'

class BillingImportWorker
  include Sneakers::Worker

  from_queue 'import.billing', prefetch: 5, threads: 5

  def work(msg)
    msg = JSON.parse(msg).deep_symbolize_keys
    BillingsImportService.process(msg)
    ack!
  end
end
