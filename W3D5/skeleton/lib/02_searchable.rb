require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    # ...
    text = params.keys.map { |key| "#{key} = ?" }.join(" AND ")

    results = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{text}
    SQL

    parse_all(results)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
