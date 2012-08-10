class ChangeInputs < ActiveRecord::Migration
  def change
    add_column :inputs, :inputset_id, :integer
    remove_column :inputs, :name
    remove_column :inputs, :admin
  end
  
end
