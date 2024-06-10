class SendBillingsEvent < BaseEvent
  QUEUE_NAME = "send.billing"

  def initialize(payload)
    @queue_name = QUEUE_NAME
    @payload = payload
  end
end
