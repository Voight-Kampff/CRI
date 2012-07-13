class AddCommentsToData < ActiveRecord::Migration
  def change 
    add_column :inputs, :comment, :string
  end
end
