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

  def memcached_queue
    list_queues.find{|url| url == "https://sqs.us-west-2.amazonaws.com/583221719064/FOD-DEV-ELASTICACHE_MEMCACHED"}
  end

  def redis_queue
    list_queues.find{|url| url == "https://sqs.us-west-2.amazonaws.com/583221719064/FOD-DEV-ELASTICACHE_REDIS"}
  end

  def receive_messages(queue_url)
    @client.receive_message(queue_url: queue_url, max_number_of_messages: 10)
  rescue => exception
    Rails.logger.warn exception.message
    []
  end

  def purge_queue(queue_url)
    @client.purge_queue(queue_url: queue_url)
  rescue Aws::SQS::Errors::PurgeQueueInProgress => exception
    Rails.logger.warn exception.message
  end

end
