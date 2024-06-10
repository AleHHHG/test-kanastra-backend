# frozen_string_literal: true

class BillingMailer < ApplicationMailer
  def notification(billing_id)
    @billing = Billing.find(billing_id)
    @billing.update(sent: true)
    mail(to: @billing.email, subject: 'Cobrança disponivel')
  end
end
