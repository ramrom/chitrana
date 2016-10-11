class Metric < ActiveRecord::Base
  def self.get_data(metric_name:, opts: {})
    start_time = Time.now
    cache_expiration = 'unknown'
    cache_hit = false

    metric = AppConfig.metrics[metric_name]
    return { error: "#{metric_name} metric name does not exist" } if metric.blank?

    if opts[:ignore_cache].present?
      result = retrieve_from_data_source(metric)
      return result if result[:error].present?
      Rails.cache.write metric_name, result, expires_in: metric.cache_duration.seconds
    else
      cache_object = Rails.cache.send(:read_entry, metric_name, {})
      if cache_object.kind_of?(ActiveSupport::Cache::Entry)
        cache_hit = true
        cache_expiration = Time.at(cache_object.expires_at) - Time.now
        result = Rails.cache.read metric_name
      else
        result = retrieve_from_data_source(metric)
        return result if result.kind_of?(Hash) && result[:error].present?
        Rails.cache.write metric_name, result, expires_in: metric.cache_duration.seconds
        cache_expiration = metric.cache_duration
      end
    end

    total_time = Time.now - start_time
    Rails.logger.info "metric_name: #{metric_name}, query_time: #{total_time},\
      cache_hit: #{cache_hit}, cache_expiration: #{cache_expiration}"
    {
      data: result,
      query_time: total_time,
      cache_hit: cache_hit,
      cache_expiration: cache_expiration
    }
  end

  def self.retrieve_from_data_source(metric)
    case metric.data_source
    when 'portfolio'
      result = DataSource.portfolio_db.exec metric.sql
      transform_data(result)
    when 'eis'
      result = EISSource.connection.execute metric.sql
      transform_data(result)
    else
      { error: "metric #{metric_name}, unknown data source: #{metric.data_source}" }
    end
  rescue PG::Error, ActiveRecord::ActiveRecordError => e
    { error: e.message, stack: e.backtrace }
  end

  def self.transform_data(result)
    result.to_a.map do |data_point|
      data_point.each_with_object({}) do |(k,v),o|
        if k.to_sym == :count
          o['value'] = v
        elsif k.to_sym == :date
          o['date'] = v
        else
          o[k] = v
        end
      end
    end
  end

  def self.retrieve_data_from_cache
    Rails.cache.fetch "mykey"
  end

  def self.write_data_to_cache
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
