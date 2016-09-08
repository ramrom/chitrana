class DataSource
  def self.local_db
    conn = PG::Connection.open(dbname: 'chitrana_development')
  end
end
