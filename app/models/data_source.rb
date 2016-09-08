class DataSource
  def self.local_db
    conn = PG::Connection.open('chitrana_development')
  end
end
