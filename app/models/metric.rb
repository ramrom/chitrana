class Metric < ActiveRecord::Base
  def self.get_data
    sql = AppConfig.metric_sqls.loans_per_day.sql
    result = EISSource.connection.execute sql
    result.to_a
  end

  def self.get_cached_data
    Rails.cache.fetch "mykey"
  end

  def self.put_cached_data
    Rails.cache.write "mykey", "mydata", expires_in: 5.seconds
  end

  # so the read_entry method will return nil object if the key expired
  def self.cache_expires_at(cache_key)
    Time.at(Rails.cache.send(:read_entry, cache_key, {}).expires_at)
  end

  def self.cache_key_expired?(cache_key)
    Rails.cache.send(:read_entry, cache_key, {}).expired?
  end
end
