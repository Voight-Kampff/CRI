class ChangeInputSets < ActiveRecord::Migration
  change_table :Inputsets do |t|
    t.remove :updatefreq
    t.string :updatefreq
  end
end