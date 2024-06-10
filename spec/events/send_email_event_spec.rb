# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendEmailEvent, type: :event do
  describe '#publish!' do
    subject { described_class.new(payload) }
    let(:payload) do
      {
        mailer: 'BillingMailer',
        mail_method: 'notification',
        args: [1]
      }
    end

    before do
      allow(PublisherService).to receive(:publish)
    end

    it 'return queue name' do
      subject.publish!
      expect(subject.queue_name).to include('send.email')
    end
  end
end
