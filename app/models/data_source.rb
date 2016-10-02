class DataSource
  def self.local_db
    conn = PG::Connection.open(dbname: 'chitrana_development')
    # conn.exec 'select * from blah'
  end

  def self.pp(res)
    rows_count = res.num_tuples
    column_names = res.fields
    col_header = column_names.join(', ')

    puts col_header

    for i in 0..rows_count-1
      row_hash = res[i]
      row_arr = []
      column_names.each { |col| row_arr << row_hash[col] }
      row = row_arr.join(', ')
      puts row
    end
  end
end
