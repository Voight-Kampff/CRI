class Input < ActiveRecord::Base
  attr_accessible :name, :value, :user_id, :unit, :period, :admin, :comment
  
  belongs_to :user
  
  validates :user_id, presence: true
  validates :name, presence: true
  validates :value, presence: true
  validates :period, presence: true
  
   default_scope order: 'inputs.period DESC'
   
   def input_range(name)
     @inputs = Input.where("name = ?", name)
     @start= @inputs.first.period
     @end = Inpu
   end
     
     
end
