Sneakers.configure(
  amqp: 'amqp://user:password@rabbitmq',
  vhost: 'kanastra',
  workers: 5
)
Sneakers.logger.level = Logger::INFO