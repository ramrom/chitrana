class Chart < ActiveRecord::Base
  def self.get_data
    sql = AppConfig.chart_sqls.loans_per_day.sql
    result = EISSource.connection.execute sql
    result.to_a
  end
end
