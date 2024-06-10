require 'rails_helper'

RSpec.describe Billing, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:document) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:due_date) }
    it { should validate_presence_of(:uuid) }
    it { should validate_uniqueness_of(:uuid) }
  end

  describe 'scopes' do
    let!(:billing_due_today) { create(:billing, due_date: Date.current, sent: false) }
    let!(:billing_due_tomorrow) { create(:billing, due_date: Date.current + 1.day, sent: false) }
    let!(:billing_sent) { create(:billing, due_date: Date.current, sent: true) }

    describe '.by_due_date' do
      it 'returns billings with the specified due date' do
        expect(Billing.by_due_date(Date.current)).to include(billing_due_today)
        expect(Billing.by_due_date(Date.current)).not_to include(billing_due_tomorrow)
      end
    end

    describe '.not_sent' do
      it 'returns billings that have not been sent' do
        expect(Billing.not_sent).to include(billing_due_today, billing_due_tomorrow)
        expect(Billing.not_sent).not_to include(billing_sent)
      end
    end
  end
end
