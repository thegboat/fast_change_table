module FastChangeTable
  module TableInstanceMethods
    def initialize(table_name, base)
      @table_name = table_name
      @base = base
      @renamed_columns = []
    end
  
    def renamed_columns
      @renamed_columns || []
    end
  
    def rename(column_name, new_column_name)
      @renamed_columns ||= []
      @renamed_columns << [column_name, new_column_name]
      @base.rename_column(@table_name, column_name, new_column_name)
    end
  end
end