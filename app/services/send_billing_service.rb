# frozen_string_literal: true

class SendBillingService
  class << self
    #Escreve os itens no rabbitmq
    def publish
      billing_ids = Billing.by_due_date(Date.current - 10.days).not_sent.pluck(:id)
      SendBillingsEvent.new({ billing_ids: billing_ids }).publish!
    end

    #Envia as cobraças por email
    def process(payload)
      payload[:billing_ids].each do |billing_id|
        MailerService.send(BillingMailer, :notification, billing_id)
      end
    end
  end
end
