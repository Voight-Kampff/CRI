class CreateInputsets < ActiveRecord::Migration
  def change
    create_table :inputsets do |t|
      t.string :name
      t.integer :user_id
      t.integer :updatefreq
      t.string :description

      t.timestamps
    end
  end
end
