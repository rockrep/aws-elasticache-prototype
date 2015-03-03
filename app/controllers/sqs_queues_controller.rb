class SqsQueuesController < ApplicationController

  def purge
    SqsClient.instance.purge_queue
    redirect_to root_path
  end
end
