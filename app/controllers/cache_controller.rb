class CacheController < ApplicationController

  # stores 10000 k/v
  def create
    count = Cache.count || 0
    (0...1000).each do |i|
      Rails.cache.fetch("k-#{i + count}") do
        i + count
      end
    end
    Cache.bump(1000)
    redirect_to root_path
  end

  def index
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

    redirect_to root_path
  end

  def clear
    Cache.clear
    Rails.cache.clear
    redirect_to root_path
  end
end
