# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendBillingService, type: :service do
  describe '.publish' do
    let(:billing_ids) { [1, 2, 3] }
    let(:send_billings_event) { instance_double(SendBillingsEvent, publish!: true) }

    before do
      allow(Billing).to receive_message_chain(:by_due_date, :not_sent, :pluck).and_return(billing_ids)
      allow(SendBillingsEvent).to receive(:new).with({ billing_ids: billing_ids }).and_return(send_billings_event)
    end

    it 'retrieves billing IDs by due date and not sent' do
      SendBillingService.publish
      expect(Billing).to have_received(:by_due_date).with(Date.current - 10.days)
      expect(Billing.by_due_date(nil)).to have_received(:not_sent)
      expect(Billing.by_due_date(nil).not_sent).to have_received(:pluck).with(:id)
    end

    it 'creates and publishes a SendBillingsEvent' do
      SendBillingService.publish
      expect(SendBillingsEvent).to have_received(:new).with({ billing_ids: billing_ids })
      expect(send_billings_event).to have_received(:publish!)
    end
  end

  describe '.process' do
    let(:payload) { { billing_ids: [1, 2, 3] } }

    before do
      allow(MailerService).to receive(:send)
    end

    it 'sends notifications for each billing ID in the payload' do
      SendBillingService.process(payload)
      payload[:billing_ids].each do |billing_id|
        expect(MailerService).to have_received(:send).with(BillingMailer, :notification, billing_id)
      end
    end
  end
end
