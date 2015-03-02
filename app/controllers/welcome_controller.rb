class WelcomeController < ApplicationController

  def index
    @servers = Rails.application.elasticache.try(:servers) || []
    @cache_store_servers = Rails.cache.instance_variable_get(:@data).instance_variable_get(:@servers)
    @cache_count = Cache.count
    @misses = Rails.cache.read("misses")
    @hits = Rails.cache.read("hits")
  end
end

