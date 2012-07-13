class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.string :name
      t.float :value
      t.integer :user_id
      t.date :period
      t.string :unit
      t.boolean :admin
      t.timestamps
    end
    add_index :inputs, [:user_id, :period, :name]
  end
end
