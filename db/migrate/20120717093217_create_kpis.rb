class CreateKpis < ActiveRecord::Migration
  def change
    create_table :kpis do |t|
      t.string :value
      t.string :target
      t.string :unit
      t.date :period
      t.boolean :admin

      t.timestamps
    end
  end
end
