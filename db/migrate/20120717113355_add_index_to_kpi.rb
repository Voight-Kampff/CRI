class AddIndexToKpi < ActiveRecord::Migration
  def change
    add_index :kpis, [:user_id, :period, :name]
  end
end
