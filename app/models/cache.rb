class Cache

  @@count = 0

  cattr_reader :count

  def self.bump(count)
    @@count += count
  end

  def self.clear
    @@count = 0
    Rails.cache.delete("misses")
    Rails.cache.delete("hits")
  end
end

