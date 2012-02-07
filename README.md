#Fast Change Table

Use fast\_change\_table instead of change_table in your migrations on large tables of data. Uses a duplication pattern to speed things up.

__Known issues:__

* Currently fast\_change\_table transformations do not support Rails 3 reversible migration method.


__Usage:__

uses ordinary change_table syntax but adds two options

* "replace\_keys" to remove all indexes; new indexes will be specified
- "disable\_keys" to remove indexes and apply them after data load; this is a tremendous performance enhancement for a dbms with fast index creation; it is active by default. set it to false to prevent its usage

the bulk option is set by default; set it to false to prevent its usage.

__Example:__

    fast_change_table :table_name, :disable_keys => true do |t|
      t.change :old_string, :string, :limit => 64
      t.rename :old_string, :new_string
      t.integer :an_integer
    end


__other methods:__

create\_table\_like(orignal\_table, table\_to\_copy\_to)
  creates a table with the same structure
  
disable\_indexes(table)
  removes all indexes from a table, returns a list of index objects removed.  uses bulk alter when possible
  
enable\_indexes(table, list\_of\_indexes)
  restores a list of indexes to a table.  uses bulk alter when possible
  
fast\_add\_indexes(table, &block)
  allows you to pass a block to add indexes.  uses bulk alter when possible
  
__Example:__
  
  
    fast_add_indexes :sometable do |t|
     t.index :some_column
     t.index [:some_other_column, :column_three], :name => "a_multicolumn_index"
    end
  
copy\_table(from\_table, to\_table, remaps = [])
  
* copies rows from one table into another.
  by default copies data from column of from_table to to_table of same name.
  will not copy data where there is no corresponding column.
  the remaps argument can be supplied to tell copy table how to handle unmatched columns or override this behavior
  for multiple remap columns provide an array of 2 element arrays
  
__Examples:__

  
    copy_table(old_users_without_email_hash, new_table, ['MD5(email)', 'email_hash'])
  
    copy_table(old_users_without_total, new_table, [['sum(payments)', 'total_payments'], ['avg(payments)', 'average_payments']])