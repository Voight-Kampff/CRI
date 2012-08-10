class CreateKpisets < ActiveRecord::Migration
  def change
    create_table :kpisets do |t|
      t.string :name
      t.integer :user_id
      t.string :updatefreq
      t.string :description

      t.timestamps
    end
    add_index :kpisets, :name, unique: true
  end
end
