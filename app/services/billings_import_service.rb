# frozen_string_literal: true

require 'csv'

class BillingsImportService
  class << self
    #Escreve os itens no rabbitmq separados em blocos de 1000 registros
    def publish(file)
      CSV.read(file.tempfile)[1..-1].each_slice(1000).each do |batch|
        ImportBillingsEvent.new({ billings: batch }).publish!
      end
    end

    #Salva os itens no banco de dados
    def process(payload)
      items = payload[:billings].map do |item|
        "('#{item[0]}', '#{item[1]}', '#{item[2]}', #{item[3]}, '#{item[4]}', '#{item[5]}')"
      end
      sql = "INSERT INTO BILLINGS (name, document, email, amount, due_date, uuid ) values #{items.join(',')}"
      ActiveRecord::Base.connection.execute(sql)
    end
  end
end
