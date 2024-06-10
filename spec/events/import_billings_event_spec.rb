# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportBillingsEvent, type: :event do
  describe '#publish!' do
    subject { described_class.new(payload) }
    let(:payload) do
      {
        billings: [['name','document','email','amount','due_date', 'uuid']]
      }
    end

    before do
      allow(PublisherService).to receive(:publish)
    end

    it 'return queue name' do
      subject.publish!
      expect(subject.queue_name).to include('import.billing')
    end
  end
end
