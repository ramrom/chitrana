class CreateBaseTables < ActiveRecord::Migration
  def up
    #execute <<-SQL
    #  CREATE SCHEMA CHITRANA;
    #SQL
    create_charts_table
    #create_data_sources_table
    #create_users_table

    # TODO: create indexes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

  def create_charts_table
    execute <<-SQL
      CREATE TABLE charts
      (
        chart_id        serial PRIMARY KEY,
        name            varchar(32),
        description     varchar(64),
        query           text,
        created_at      timestamp NOT NULL,
        updated_at      timestamp NOT NULL
      );
    SQL
  end

  def create_data_sources_table
    execute <<-SQL
      CREATE TABLE chitrana.data_sources
      (
        data_source_id serial PRIMARY KEY,
        data_source    VARCHAR(32),
        description    text,
        created_at     timestamp NOT NULL,
        updated_at     timestamp NOT NULL
      );
    SQL
  end

  def create_users_table
    execute <<-SQL
      CREATE TABLE chitrana.users
      (
        user_id     serial PRIMARY KEY,
        username    varchar(32),
        config      json,
        created_at  timestamp NOT NULL,
        updated_at  timestamp NOT NULL
      );
    SQL
  end
end
