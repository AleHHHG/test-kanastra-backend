# frozen_string_literal: true

class BillingsController < ApplicationController
  def index
    @pagy, @billings = pagy(Billing.all.order(due_date: :desc, uuid: :desc))
    render json: { items: @billings }
  end

  def import
    return render json: { message: 'Formato inválido' }, status: :bad_request unless valid_content_type?

    if BillingsImportService.publish(params[:file])
      render json: { message: 'Arquivo importado com sucesso' }, status: :ok
    else
      render json: { message: 'Falha ao importar o arquivo' }, status: :internal_server_error
    end
  end

  private

  def valid_content_type?
    params[:file].content_type == "text/csv"
  end
end
