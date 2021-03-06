class BaseRepository
  def initialize
    @table_columns.each do |column|
      self.class.send(:define_method, "find_all_by_#{column}") do |value|
        check_all_records(column, value)
      end

      self.class.send(:define_method, "find_by_#{column}") do |value|
        check_all_records(column, value).first
      end
    end
    @all_data = []
  end

  def add(item)
    @all_data << item
  end

  def all
    @all_data
  end

  def random
    @all_data.sample
  end

  private

  def check_all_records(column, value)
    @all_data.select do |customer|
      customer.send(column).downcase == value.downcase
    end
  end
end