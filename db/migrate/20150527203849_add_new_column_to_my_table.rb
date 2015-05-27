class AddNewColumnToMyTable < ActiveRecord::Migration
  self.up
    add_column :tablename, :new_column, :type
  end
end
