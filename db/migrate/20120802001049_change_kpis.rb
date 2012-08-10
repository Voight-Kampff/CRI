class ChangeKpis < ActiveRecord::Migration
  def change
  	add_column :kpis, :kpiset_id, :integer
  	remove_column :kpis, :name
  	remove_column :kpis, :admin
  end

end
