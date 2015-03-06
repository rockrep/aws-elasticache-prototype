class SqsQueuesController < ApplicationController

  def purge
    SqsClient.instance.purge_queue(SqsClient.instance.memcached_queue)
    redirect_to root_path
  end
end
