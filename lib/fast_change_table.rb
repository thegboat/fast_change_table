require 'active_record'
require 'fast_change_table/table'
require 'fast_change_table/fast_change_table'
require 'fast_change_table/version'

module FastChangeTable
  # def self.included(base)
  #   base.extend ClassMethods
  # end
end

::ActiveRecord::ConnectionAdapters::AbstractAdapter.send :include, FastChangeTable::InstanceMethods
::ActiveRecord::ConnectionAdapters::Table.send :include, FastChangeTable::TableInstanceMethods