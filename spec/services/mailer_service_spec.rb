# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MailerService, type: :service do
  describe '.publish' do
    let(:mailer) { double("Mailer") }
    let(:mail_method) { :notification }
    let(:args) { [1, 2, 3] }
    let(:payload) { { mailer: mailer.to_s, mail_method: mail_method.to_s, args: args } }
    let(:send_email_event) { instance_double(SendEmailEvent, publish!: true) }

    before do
      allow(SendEmailEvent).to receive(:new).with(payload).and_return(send_email_event)
    end

    it 'creates a new SendEmailEvent with the correct payload' do
      MailerService.publish(mailer, mail_method, *args)
      expect(SendEmailEvent).to have_received(:new).with(payload)
    end

    it 'calls publish! on the SendEmailEvent instance' do
      MailerService.publish(mailer, mail_method, *args)
      expect(send_email_event).to have_received(:publish!)
    end
  end
end
