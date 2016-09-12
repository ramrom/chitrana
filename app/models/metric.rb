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
end
