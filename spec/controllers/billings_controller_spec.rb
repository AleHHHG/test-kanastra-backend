# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillingsController, type: :controller do
  describe "GET #index" do
    it "returns a list of billings ordered by due date" do
      billing = create(:billing, due_date: Date.today)

      get :index
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ items: [billing.as_json] }.as_json)
    end

    it "returns a list of billings paginate" do
      billings = create_list(:billing, 100)

      get :index
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['items'].count).to eq(10)
    end
  end

  describe "POST #import" do
    context "with valid content type" do
      it "imports the file successfully" do
        file = fixture_file_upload('billings.csv', 'text/csv')
        allow(BillingsImportService).to receive(:publish).and_return(true)

        post :import, params: { file: file }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq({ message: 'Arquivo importado com sucesso' }.as_json)
      end
    end

    context "with invalid content type" do

      it "returns bad request" do
        file = fixture_file_upload('billings.csv', 'application/pdf')

        post :import, params: { file: file }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ message: 'Formato inválido' }.as_json)
      end
    end

    context "when import service fails" do

      it "returns internal server error" do
        file = fixture_file_upload('billings.csv', 'text/csv')
        allow(BillingsImportService).to receive(:publish).and_return(false)

        post :import, params: { file: file }
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)).to eq({ message: 'Falha ao importar o arquivo' }.as_json)
      end
    end
  end
end
