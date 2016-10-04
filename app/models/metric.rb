class Metric < ActiveRecord::Base
  def self.get_data(metric_name:, opts: {})
    metric = AppConfig.metrics[metric_name]
    return { error: "#{metric_name} metric name does not exist" } if metric.blank?

    #result = retrieve_from_cache unless options[:ignore_cache].present?

    case metric.data_source
    when 'portfolio'
      result = DataSource.portfolio_db.exec metric.sql
    when 'eis'
      result = EISSource.connection.execute metric.sql
    else
      return { error: "metric #{metric_name}, unknown data source: #{metric.data_source}" }
    end
    result.to_a
  end

  def self.retrive_from_data_source
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

  def as_json(options = {})
  end
end
