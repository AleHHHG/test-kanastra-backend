# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendBillingsEvent, type: :event do
  describe '#publish!' do
    subject { described_class.new(payload) }
    let(:payload) do
      {
        billing_ids: [1,2,3]
      }
    end

    before do
      allow(PublisherService).to receive(:publish)
    end

    it 'return queue name' do
      subject.publish!
      expect(subject.queue_name).to include('send.billing')
    end
  end
end
