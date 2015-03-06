class Cache

  def self.bump(val = 0)
    Rails.application.redis_write.set("cache_count", count + val)
  end

  def self.count
    Rails.application.redis_read.get("cache_count").to_i || 0
  end

  def self.clear
    Rails.application.redis_write.set("cache_count", 0)
    Rails.application.redis_write.del("misses")
    Rails.application.redis_write.del("hits")
  end

  def self.misses=(misses = 0)
    Rails.application.redis_write.set("misses", misses)
  end

  def self.misses
    Rails.application.redis_read.get("misses")
  end

  def self.hits=(hits = 0)
    Rails.application.redis_write.set("hits", hits)
  end

  def self.hits
    Rails.application.redis_read.get("hits")
  end

end

