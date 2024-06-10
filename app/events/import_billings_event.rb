class ImportBillingsEvent < BaseEvent
  QUEUE_NAME = "import.billing"

  def initialize(payload)
    @queue_name = QUEUE_NAME
    @payload = payload
  end
end
