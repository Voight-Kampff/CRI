class Input < ActiveRecord::Base
  attr_accessible :value, :user_id, :unit, :period, :inputset_id, :comment
  
  belongs_to :inputset
  
  validates :user_id, presence: true
  validates :inputset_id, presence: true
  validates :value, presence: true, length: { maximum: 20 }
  validates :period, presence: true
  
  validates :unit, length: { maximum: 10}
  validates :comment, length: { maximum: 140 }
  
   default_scope order: 'inputs.period DESC'
   
   def date(input,foo)
   	if input.inputset.updatefreq == "Daily" 
   		if foo==0
   			return (Date.today)-1
   		elsif foo==1
   			return (input.period)+1
   		elsif foo== -1
   			return (input.period)-1
   		else
   			return "something went wrong"
   		end

   	elsif input.inputset.updatefreq == "Weekly" 
   		if foo==0
   			return (Date.today<<1).beginning_of_month
   		elsif foo==1
   			return (input.period).next_week
   		elsif foo== -1
   			return (input.period).prev_week
   		else
   			return "something went wrong"
   		end

   	elsif input.inputset.updatefreq == "Biweekly" 
   		if foo==0
   			return (Date.today<<1).beginning_of_month
   		elsif foo==1
   			return (input.period).next_week.next_week
   		elsif foo== -1
   			return (input.period).prev_week.prev_week
   		else
   			return "something went wrong"
   		end
   		
   	elsif input.inputset.updatefreq == "Monthly" 
   		if foo==0
   			return (Date.today<<1).beginning_of_month
   		elsif foo==1
   			return (input.period)>>1
   		elsif foo== -1
   			return (input.period)<<1
   		else
   			return "something went wrong"
   		end

   	elsif input.inputset.updatefreq == "Bimonthly" 
   		if foo==0
   			return (Date.today<<1).beginning_of_month
   		elsif foo==1
   			return (input.period).>>2
   		elsif foo== -1
   			return (input.period).<<2
   		else
   			return "something went wrong"
   		end

   	elsif input.inputset.updatefreq == "Quarterly" 
   		if foo==0
   			return (Date.today<<1).beginning_of_month
   		elsif foo==1
   			return (input.period).>>3
   		elsif foo== -1
   			return (input.period).<<3
   		else
   			return "something went wrong"
   		end

   	elsif input.inputset.updatefreq == "Annual" 
   		if foo==0
   			return (Date.today<<1).beginning_of_month
   		elsif foo==1
   			return (input.period).next_year
   		elsif foo== -1
   			return (input.period).prev_year
   		else
   			return "something went wrong in Annual new"
   		end

   	else
   		return "ble"
   	end
   end

   def showdate(input,foo)
   	if input.inputset.updatefreq == "Daily"
   		if foo==0
   			return input.period.to_formatted_s(:rfc822)
   		elsif foo==1
   			return (input.period+1).to_formatted_s(:rfc822)
   		elsif foo==-1
   			return (input.period-1).to_formatted_s(:rfc822)
   		else 
   			return "something went wrong in Daily view"
   		end

   	elsif input.inputset.updatefreq == "Weekly" 
   		if foo==0
   			a = "Mon "
	  		b = (input.period).to_formatted_s(:short)
	  		c = " to "
	  		d = " Sun "
	  		e = (input.period).end_of_week.to_formatted_s(:rfc822)
	  		return a+b+c+d+e
   		elsif foo==1
   			a = "Mon "
	  		b = (input.period).next_week.to_formatted_s(:short)
	  		c = " to "
	  		d = " Sun "
	  		e = (input.period).next_week.end_of_week.to_formatted_s(:rfc822)
	  		return a+b+c+d+e
   		elsif foo== -1
   			a = "Mon "
	  		b = (input.period).prev_week.to_formatted_s(:short)
	  		c = " to "
	  		d = " Sun "
	  		e = (input.period).prev_week.end_of_week.to_formatted_s(:rfc822)
	  		return a+b+c+d+e
   		else
   			return "something went wrong"
   		end
   	elsif input.inputset.updatefreq == "Biweekly"
   		if foo==0
   			a = "Mon "
	  		b = (input.period).to_formatted_s(:short)
	  		c = " to "
	  		d = " Sun "
	  		e = (input.period).next_week.end_of_week.to_formatted_s(:rfc822)
	  		return a+b+c+d+e
	  	elsif foo==1
	  		a = "Mon "
	  		b = (input.period).next_week.next_week.to_formatted_s(:short)
	  		c = " to "
	  		d = " Sun "
	  		e = (input.period).next_week.next_week.next_week.end_of_week.to_formatted_s(:rfc822)
	  		return a+b+c+d+e
	  	elsif foo==-1
	  		a = "Mon "
	  		b = (input.period).prev_week.prev_week.to_formatted_s(:short)
	  		c = " to "
	  		d = " Sun "
	  		e = (input.period).prev_week.end_of_week.to_formatted_s(:rfc822)
	  		return a+b+c+d+e
	  	else
	  		return "something went wrong in Biweekly view"
	  	end
	elsif input.inputset.updatefreq == "Monthly"
		if foo==0
			return input.period.to_formatted_s(:month_and_year)
		elsif foo==1
			return (input.period>>1).to_formatted_s(:month_and_year)
		elsif foo==-1
			return (input.period<<1).to_formatted_s(:month_and_year)
		else
			return "something went wrong in Monthly view"
		end
	elsif input.inputset.updatefreq == "Bimonthly"
		if foo==0
	  		a = (input.period).strftime("%B")
	  		b = "-"
	  		c = (input.period>>1).to_formatted_s(:month_and_year)
	  		return a+b+c
	  	elsif foo==1
	  		a = (input.period>>3).strftime("%B")
	  		b = "-"
	  		c = (input.period>>4).to_formatted_s(:month_and_year)
	  		return a+b+c
	  	elsif foo==-1
	  		a = (input.period<<2).strftime("%B")
	  		b = "-"
	  		c = (input.period<<1).to_formatted_s(:month_and_year)
	  		return a+b+c
	  	else
			return "something went wrong in Bimonthly view"
		end
	elsif input.inputset.updatefreq == "Quarterly"
		if foo==0
			a = ((input.period).at_beginning_of_quarter).strftime("%B")
	  		b = "-"
	  		c = (((input.period).at_beginning_of_quarter)>>2).to_formatted_s(:month_and_year)
	  		return a+b+c
	  	elsif foo==1
	  		a = ((input.period>>3).at_beginning_of_quarter).strftime("%B")
	  		b = "-"
	  		c = (((input.period).at_beginning_of_quarter)>>2).to_formatted_s(:month_and_year)
	  		return a+b+c
	  	elsif foo==-1
	  		a = ((input.period<<3).at_beginning_of_quarter).strftime("%B")
	  		b = "-"
	  		c = (((input.period).at_beginning_of_quarter)<<2).to_formatted_s(:month_and_year)
	  		return a+b+c
	  	else
	  		return "something went wrong in Quarterly view"
	  	end
	elsif input.inputset.updatefreq == "Annual"
		if foo==0
			return (input.period).strftime("%Y")
		elsif foo==1
			return ((input.period).next_year).strftime("%Y")
		elsif foo==-1
			return ((input.period).prev_year).strftime("%Y")
		else
			return "something went wrong in annual"
		end
   	else
   		return "ble"
   	end
   end


  
   
end
