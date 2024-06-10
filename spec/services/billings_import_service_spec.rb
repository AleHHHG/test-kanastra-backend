# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillingsImportService, type: :service do
  describe '.publish' do
    let(:file) { fixture_file_upload('billings.csv', 'text/csv') }

    before do
      allow(CSV).to receive(:read).and_return([
        ['name', 'document', 'email', 'amount', 'due_date', 'uuid'],
        ['John Doe', '12345678900', 'john@example.com', '1000.0', '2023-06-01', 'uuid1'],
        ['Jane Doe', '09876543211', 'jane@example.com', '2000.0', '2023-07-01', 'uuid2']
      ])
    end

    it 'reads the CSV file and publishes batches of billings' do
      expect(ImportBillingsEvent).to receive(:new).with({ billings: [['John Doe', '12345678900', 'john@example.com', '1000.0', '2023-06-01', 'uuid1'], ['Jane Doe', '09876543211', 'jane@example.com', '2000.0', '2023-07-01', 'uuid2']] }).and_return(double(publish!: true))

      BillingsImportService.publish(file)
    end
  end

  describe '.process' do
    let(:payload) do
      {
        billings: [
          ['John Doe', '12345678900', 'john@example.com', '1000.0', '2023-06-01', 'uuid1'],
          ['Jane Doe', '09876543211', 'jane@example.com', '2000.0', '2023-07-01', 'uuid2']
        ]
      }
    end

    it 'inserts the billings into the database' do
      expected_sql = "INSERT INTO BILLINGS (name, document, email, amount, due_date, uuid ) values ('John Doe', '12345678900', 'john@example.com', 1000.0, '2023-06-01', 'uuid1'),('Jane Doe', '09876543211', 'jane@example.com', 2000.0, '2023-07-01', 'uuid2')"

      expect(ActiveRecord::Base.connection).to receive(:execute).with(expected_sql)

      BillingsImportService.process(payload)
    end
  end
end
