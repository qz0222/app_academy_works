require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    temp = DBConnection.execute2(<<-SQL).first
      select
      *
      from
      #{self.table_name}
      limit
      0
    SQL

    @columns = temp.map(&:to_sym)


  end

  def self.finalize!
    self.columns.each do |name|
      define_method(name) do
        self.attributes[name]
      end

      define_method("#{name}=") do |value|
        self.attributes[name] = value
      end
    end

  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name || self.name.tableize
  end

  def self.all
    # ...
    temp = DBConnection.execute(<<-SQL)
      select
      *
      from
      #{self.table_name}

    SQL

    parse_all(temp)
  end

  def self.parse_all(results)
    # ...
    results.map{|el| self.new(el)}
  end

  def self.find(id)
    # ...
    temp = DBConnection.execute(<<-SQL, id)
      select
        *
      from
        #{self.table_name}
      where
        id = ?
    SQL
    parse_all(temp).first
  end

  def initialize(params = {})
    # ...
    params.each do |key, value|
      name = key.to_sym
      if self.class.columns.include?(name)
        self.send("#{name}=", value)
      else
        raise "unknown attribute '#{name}'"
      end
    end

  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
    self.class.columns.map { |attr| self.send(attr) }
  end

  def insert
    # ...
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(",")
    question_marks = (["?"] * columns.count).join(",")
    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id =  DBConnection.last_insert_row_id

  end

  def update
    # ...
    set_line = self.class.columns
      .map { |attr| "#{attr} = ?" }.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    # ...
    if id.nil?
      insert
    else
      update
    end
  end
end
