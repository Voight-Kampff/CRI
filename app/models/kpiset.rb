class Kpiset < ActiveRecord::Base
  attr_accessible :description, :name, :updatefreq, :user_id

  belongs_to :user
  has_many :kpis, dependent: :destroy

  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 50 }
  validates :user_id, presence: true
  validates :updatefreq, presence: true
  validates :description, length: { maximum: 560 }
  
  default_scope order: 'kpisets.name Desc'

  def newdate(kpiset, foo)
  	if foo == -1
		if kpiset.updatefreq == "Daily"
	  		return (Date.today)-1
	  	elsif kpiset.updatefreq == "Weekly"
	  		return (Date.today).prev_week
	  	elsif kpiset.updatefreq == "Biweekly"
	  		return (Date.today).prev_week.prev_week
		elsif kpiset.updatefreq == "Monthly"
	  		return ((Date.today)<<1).at_beginning_of_month
	  	elsif kpiset.updatefreq == "Bimonthly"
	  		return ((Date.today)<<2).at_beginning_of_month
	  	elsif kpiset.updatefreq == "Quarterly"
	  		return (Date.today).at_beginning_of_quarter<<3
	  	elsif kpiset.updatefreq == "Annual"
	  		return (Date.today).at_beginning_of_year.prev_year
	  	else
	  		return "Something went wrong in hidden set"
	  	end
	elsif foo == 0
		if kpiset.updatefreq == "Daily"
	  		return ((Date.today)-1).to_formatted_s(:rfc822)
	  	elsif kpiset.updatefreq == "Weekly"
	  		a = "Mon "
	  		b = (Date.today).prev_week.beginning_of_week.to_formatted_s(:short)
	  		c = " to "
	  		d = " Sun "
	  		e = (Date.today).prev_week.end_of_week.to_formatted_s(:rfc822)
	  		return a+b+c+d+e
	  	elsif kpiset.updatefreq == "Biweekly"
	  		a = "Mon "
	  		b = (Date.today).prev_week.prev_week.to_formatted_s(:short)
	  		c = " to "
	  		d = " Sun "
	  		e = (Date.today).prev_week.end_of_week.to_formatted_s(:rfc822)
	  		return a+b+c+d+e
		elsif kpiset.updatefreq == "Monthly"
	  		return ((Date.today)<<1).to_formatted_s(:month_and_year)
	  	elsif kpiset.updatefreq == "Bimonthly"
	  		a = ((Date.today)<<2).strftime("%B")
	  		b = "-"
	  		c = ((Date.today)<<1).to_formatted_s(:month_and_year)
	  		return a+b+c
	  	elsif kpiset.updatefreq == "Quarterly"
	  		a = ((Date.today).at_beginning_of_quarter).strftime("%B")
	  		b = "-"
	  		c = (((Date.today).at_beginning_of_quarter)>>2).to_formatted_s(:month_and_year)
	  		return a+b+c
	  	elsif kpiset.updatefreq == "Annual"
	  		return (Date.today).prev_year.strftime("%Y")
	  	else
	  		return "Something went wrong in annual kpiset"
	  	end
	end
  end
end
