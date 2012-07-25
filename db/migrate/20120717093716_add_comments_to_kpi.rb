class AddCommentsToKpi < ActiveRecord::Migration
  def change 
    add_column :kpis, :comment, :string
  end
end
