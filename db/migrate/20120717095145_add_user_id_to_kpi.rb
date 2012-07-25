class AddUserIdToKpi < ActiveRecord::Migration
  def change
     add_column :kpis, :user_id, :integer
  end
end
