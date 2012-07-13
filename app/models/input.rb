class Input < ActiveRecord::Base
  attr_accessible :name, :value, :user_id, :unit, :period, :admin, :comment
  
  belongs_to :user
  
  validates :user_id, presence: true
  validates :name, presence: true,  :uniqueness => {:scope => :admin}
  validates :value, presence: true
  validates :period, presence: true, :uniqueness => {:scope => :name}
  
   default_scope order: 'inputs.period DESC'
end
