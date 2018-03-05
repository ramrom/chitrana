class Metric < ApplicationRecord
  def self.get_data(metric_name:, opts: {})
    start_time = Time.now
    cache_expiration = 'unknown'
    cache_hit = false

    metric = AppConfig.metrics[metric_name]
    return { error: "#{metric_name} metric name does not exist" } if metric.blank?

    if opts[:ignore_cache].present?
      result = retrieve_from_data_source(metric)
      return result if result[:error].present?
      Rails.cache.write metric_name, result[:data], expires_in: metric.cache_duration.seconds
      cache_expiration = metric.cache_duration.seconds
    else
      cache_object = Rails.cache.send(:read_entry, metric_name, {})
      if cache_object.kind_of?(ActiveSupport::Cache::Entry)
        cache_hit = true
        cache_expiration = Time.at(cache_object.expires_at) - Time.now
        result = { data: Rails.cache.read(metric_name) }
      else
        result = retrieve_from_data_source(metric)
        return result if result[:error].present?
        Rails.cache.write metric_name, result[:data], expires_in: metric.cache_duration.seconds
        cache_expiration = metric.cache_duration
      end
    end

    total_time = Time.now - start_time
    Rails.logger.info "metric_name: #{metric_name}, query_time: #{total_time}, data_size: #{result[:data].size}"
    Rails.logger.info "cache_hit: #{cache_hit}, cache_expiration: #{cache_expiration},\
      data_trans_time: #{result[:data_transform_time]}"
    {
      data: result[:data],
      tranform_time: result[:data_transform_time],
      query_time: total_time,
      cache_hit: cache_hit,
      cache_expiration: cache_expiration
    }
  end

  def self.retrieve_from_data_source(metric)
    case metric.data_source
    when 'portfolio'
      result = DataSource.portfolio_db.exec metric.sql
      start = Time.now
      data = transform_data(metric, result)
      { data: data, data_transform_time: Time.now - start }
    when 'identity'
      result = DataSource.identity_db.exec metric.sql
      start = Time.now
      data = transform_data(metric, result)
      { data: data, data_transform_time: Time.now - start }
    when 'eis'
      result = EISSource.connection.execute metric.sql
      start = Time.now
      data = transform_data(metric, result)
      { data: data, data_transform_time: Time.now - start }
    else
      { error: "metric #{metric.metric_name}, unknown data source: #{metric.data_source}" }
    end
  rescue PG::Error, ActiveRecord::ActiveRecordError => e
    { error: e.message, stack: e.backtrace }
  end

  def self.validate_data(metric, data)
    case metric.type
    when 'time_series_day'
      data.all? do |data_point|
        ['date', 'value'] == data_point.keys.sort &&
        data_point['date'] =~ /[1-2]\d{3}-[0-1]\d-[0-3]\d/
      end
    when 'time_series_hour'
      data.all? do |data_point|
        ['date', 'hour', 'value'] == data_point.keys.sort &&
        data_point['date'] =~ /[1-2]\d{3}-[0-1]\d-[0-3]\d/ &&
        data_point['hour'] =~ /[0-2][0-9]/
      end
    end
  end

  def self.transform_data(metric, data)
    #result.to_a.map do |data_point|
    #  data_point.each_with_object({}) do |(k,v),o|
    #    if k.to_sym == :count
    #      o['value'] = v
    #    elsif k.to_sym == :date
    #      o['date'] = v
    #    else
    #      o[k] = v
    #    end
    #  end
    #end
    data.to_a
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
