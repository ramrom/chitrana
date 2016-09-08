class CreateBaseTables < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE TABLE table_name
      (
      column_name1 data_type(size),
      column_name2 data_type(size),
      column_name3 data_type(size),
      );
    SQL
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
