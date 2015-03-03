class SqsClient

  def self.instance
    @instance ||= new
  end

  def initialize
    @client = Aws::SQS::Client.new(region: 'us-west-2')
  end

  def list_queues
    @client.list_queues.queue_urls
  rescue => exception
    Rails.logger.warn exception.message
    []
  end

  def receive_messages
    @client.receive_message(queue_url: list_queues.first, max_number_of_messages: 10)
  rescue => exception
    Rails.logger.warn exception.message
    []
  end

  def purge_queue
    @client.purge_queue(queue_url: list_queues.first)
  rescue => exception
    Rails.logger.warn exception.message
  end

end
