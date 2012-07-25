class AddNameToKpi < ActiveRecord::Migration
  def change
    add_column :kpis, :name, :string
  end
end
