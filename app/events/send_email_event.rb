class SendEmailEvent < BaseEvent
  QUEUE_NAME = "send.email"

  def initialize(payload)
    @queue_name = QUEUE_NAME
    @payload = payload
  end
end
