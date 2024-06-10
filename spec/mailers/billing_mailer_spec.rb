# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillingMailer, type: :mailer do
  describe '#notification' do
    let(:billing) { create(:billing) }

    before do
      allow(Billing).to receive(:find).with(billing.id).and_return(billing)
    end

    it 'sends an email to the billing email' do
      email = BillingMailer.notification(billing.id).deliver_now

      expect(email.to).to eq([billing.email])
      expect(email.subject).to eq('Cobrança disponivel')
    end

    it 'updates the billing sent status to true' do
      expect { BillingMailer.notification(billing.id).deliver_now }
        .to change { billing.reload.sent }
        .from(false).to(true)
    end
  end
end
