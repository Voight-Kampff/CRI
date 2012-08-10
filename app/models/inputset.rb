class Inputset < ActiveRecord::Base
  attr_accessible :description, :name, :updatefreq, :user_id
  
  belongs_to :user
  has_many :inputs, dependent: :destroy
  accepts_nested_attributes_for :inputs
  
  VALID_INPUT_REGEX = /[\w]+/i
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 50 }, format: {with: VALID_INPUT_REGEX}
  validates :user_id, presence: true
  validates :updatefreq, presence: true
  validates :description, length: { maximum: 560 }
  
  default_scope order: 'inputsets.name Desc'

  def newdate(inputset, foo)
  	if foo == -1
		if inputset.updatefreq == "Daily"
	  		return (Date.today)-1
	  	elsif inputset.updatefreq == "Weekly"
	  		return (Date.today).prev_week
	  	elsif inputset.updatefreq == "Biweekly"
	  		return (Date.today).prev_week.prev_week
		elsif inputset.updatefreq == "Monthly"
	  		return ((Date.today)<<1).at_beginning_of_month
	  	elsif inputset.updatefreq == "Bimonthly"
	  		return ((Date.today)<<2).at_beginning_of_month
	  	elsif inputset.updatefreq == "Quarterly"
	  		return (Date.today).at_beginning_of_quarter<<3
	  	elsif inputset.updatefreq == "Annual"
	  		return (Date.today).at_beginning_of_year.prev_year
	  	else
	  		return "Something went wrong in hidden set"
	  	end
	elsif foo == 0
		if inputset.updatefreq == "Daily"
	  		return ((Date.today)-1).to_formatted_s(:rfc822)
	  	elsif inputset.updatefreq == "Weekly"
	  		a = "Mon "
	  		b = (Date.today).prev_week.beginning_of_week.to_formatted_s(:short)
	  		c = " to "
	  		d = " Sun "
	  		e = (Date.today).prev_week.end_of_week.to_formatted_s(:rfc822)
	  		return a+b+c+d+e
	  	elsif inputset.updatefreq == "Biweekly"
	  		a = "Mon "
	  		b = (Date.today).prev_week.prev_week.to_formatted_s(:short)
	  		c = " to "
	  		d = " Sun "
	  		e = (Date.today).prev_week.end_of_week.to_formatted_s(:rfc822)
	  		return a+b+c+d+e
		elsif inputset.updatefreq == "Monthly"
	  		return ((Date.today)<<1).to_formatted_s(:month_and_year)
	  	elsif inputset.updatefreq == "Bimonthly"
	  		a = ((Date.today)<<2).strftime("%B")
	  		b = "-"
	  		c = ((Date.today)<<1).to_formatted_s(:month_and_year)
	  		return a+b+c
	  	elsif inputset.updatefreq == "Quarterly"
	  		a = ((Date.today).at_beginning_of_quarter).strftime("%B")
	  		b = "-"
	  		c = (((Date.today).at_beginning_of_quarter)>>2).to_formatted_s(:month_and_year)
	  		return a+b+c
	  	elsif inputset.updatefreq == "Annual"
	  		return (Date.today).prev_year.strftime("%Y")
	  	else
	  		return "Something went wrong in annual inputset"
	  	end
	end
  end
end
