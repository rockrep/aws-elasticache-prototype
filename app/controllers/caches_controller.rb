class CachesController < ApplicationController

  # stores 10000 k/v
  def create
    count = Cache.count || 0
    (0...1000).each do |i|
      Rails.cache.fetch("k-#{i + count}") do
        i + count
      end
    end
    Cache.bump(1000)
    redirect_to cache_path
  end

  def check
    misses = hits = 0
    (0...Cache.count).each do |i|
      if Rails.cache.read("k-#{i}")
        hits += 1
      else
        misses += 1
      end
    end if Cache.count > 0
    Rails.cache.write("misses", misses)
    Rails.cache.write("hits", hits)

    redirect_to cache_path
  end

  def show
    set_for_show
  end

  def destroy
    Cache.clear
    Rails.cache.clear
    redirect_to cache_path
  end

  def refresh
    Rails.application.elasticache.refresh
    redirect_to cache_path
  end

  def refresh_store
    Rails.application.config.cache_store = [:dalli_store, Rails.application.elasticache.servers, {:namespace=>"prototype", :compress=>true, :expires_in=>3.hours}]
    redirect_to cache_path
  end

  private

  def set_for_show
    @servers = Rails.application.elasticache.servers || []
    @cache_store_servers = Rails.cache.instance_variable_get(:@data).instance_variable_get(:@servers)
    @cache_count = Cache.count
    @misses = Rails.cache.read("misses")
    @hits = Rails.cache.read("hits")
  end

end
