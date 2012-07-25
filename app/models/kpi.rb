class Kpi < ActiveRecord::Base
  attr_accessible :admin, :period, :target, :unit, :value, :comment, :name
  
  belongs_to :user
  
  validates :user_id, presence: true
  validates :name, presence: true
  validates :value, presence: true
  validates :period, presence: true
  
  def calc(kpi)
    eval(Parser.parse(kpi.value))
  end
  
  def perdex(kpi)
    ((calc(kpi).to_f)/(kpi.target.to_f))*100.0
  end
  
  def state(kpi)
    if perdex(kpi)>100.0
      return "btn-success"
    elsif
      perdex(kpi)<100.0 && perdex(kpi)>70.0
      return "btn-warning"
    else
      return "btn-danger"
    end
  end
  
end
