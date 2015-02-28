class WelcomeController < ApplicationController

  def index
    @servers = Rails.application.elasticache.try(:servers) || []
    @cache_store_servers = Rails.cache.instance_variable_get(:@data).instance_variable_get(:@servers)
  end
end

