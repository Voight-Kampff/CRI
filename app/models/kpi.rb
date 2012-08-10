class Kpi < ActiveRecord::Base
  attr_accessible :value, :user_id, :unit, :period, :kpiset_id, :comment, :target
  
  belongs_to :kpiset
  
  validates :user_id, presence: true
  validates :kpiset_id, presence: true
  validates :target, presence: true, length: { maximum: 20 }
  VALID_PARSER_REGEX = /^(\()?(\b([\w]+)(\*|-|(\/)|(\+))?)*(\))$/i
  validates :value, presence: true, format: {with: VALID_PARSER_REGEX}
  validates :period, presence: true
  
  validates :unit, length: { maximum: 10}
  validates :comment, length: { maximum: 140 }
  
    default_scope order: 'kpis.period DESC'
  
  def calc(kpi)
    @@date=kpi.period
      date=@@date
      @kpi=Parser.parse(kpi.value)
      if @kpi.include?("Not Available")
        return "Data not Available"
      else
        return eval(@kpi)
      end
  end
  
  def perdex(kpi)
    
      ((calc(kpi).to_f)/(kpi.target.to_f))*100.0
    
  end
  
  def state(kpi)
    if perdex(kpi)>=100.0
      return "btn-success"
    elsif perdex(kpi)<100.0 && perdex(kpi)>=70.0
      return "btn-warning"
    elsif perdex(kpi)<100.0
      return "btn-danger"
    else
      return "this should not appear"
    end
  end
  
  def icon(kpi)
    if perdex(kpi)>=100.0
      return "icon-ok"
    elsif perdex(kpi)<100.0 && perdex(kpi)>=70.0
      return "icon-warning-sign"
    elsif perdex(kpi)<100.0
      return "icon-remove"
    else
      return "this should not appear"
    end
  end

def date(kpi,foo)
    if kpi.kpiset.updatefreq == "Daily" 
      if foo==0
        return (Date.today)-1
      elsif foo==1
        return (kpi.period)+1
      elsif foo== -1
        return (kpi.period)-1
      else
        return "something went wrong"
      end
    elsif kpi.kpiset.updatefreq == "Weekly" 
      if foo==0
        return (Date.today<<1).beginning_of_month
      elsif foo==1
        return (kpi.period).next_week
      elsif foo== -1
        return (kpi.period).prev_week
      else
        return "something went wrong"
      end
    elsif kpi.kpiset.updatefreq == "Biweekly" 
      if foo==0
        return (Date.today<<1).beginning_of_month
      elsif foo==1
        return (kpi.period).next_week.next_week
      elsif foo== -1
        return (kpi.period).prev_week.prev_week
      else
        return "something went wrong"
      end
    elsif kpi.kpiset.updatefreq == "Monthly" 
      if foo==0
        return (Date.today<<1).beginning_of_month
      elsif foo==1
        return (kpi.period)>>1
      elsif foo== -1
        return (kpi.period)<<1
      else
        return "something went wrong"
      end
    elsif kpi.kpiset.updatefreq == "Bimonthly" 
      if foo==0
        return (Date.today<<1).beginning_of_month
      elsif foo==1
        return (kpi.period).>>2
      elsif foo== -1
        return (kpi.period).<<2
      else
        return "something went wrong"
      end
    elsif kpi.kpiset.updatefreq == "Quarterly" 
      if foo==0
        return (Date.today<<1).beginning_of_month
      elsif foo==1
        return (kpi.period).>>3
      elsif foo== -1
        return (kpi.period).<<3
      else
        return "something went wrong"
      end
    elsif kpi.kpiset.updatefreq == "Annual" 
      if foo==0
        return (Date.today<<1).beginning_of_month
      elsif foo==1
        return (kpi.period).next_year
      elsif foo== -1
        return (kpi.period).prev_year
      else
        return "something went wrong in Annual new"
      end
    else
      return "ble"
    end
   end

   def showdate(kpi,foo)
    if kpi.kpiset.updatefreq == "Daily"
      if foo==0
        return kpi.period.to_formatted_s(:rfc822)
      elsif foo==1
        return (kpi.period+1).to_formatted_s(:rfc822)
      elsif foo==-1
        return (kpi.period-1).to_formatted_s(:rfc822)
      else 
        return "something went wrong in Daily view"
      end

    elsif kpi.kpiset.updatefreq == "Weekly" 
      if foo==0
        a = "Mon "
        b = (kpi.period).to_formatted_s(:short)
        c = " to "
        d = " Sun "
        e = (kpi.period).end_of_week.to_formatted_s(:rfc822)
        return a+b+c+d+e
      elsif foo==1
        a = "Mon "
        b = (kpi.period).next_week.to_formatted_s(:short)
        c = " to "
        d = " Sun "
        e = (kpi.period).next_week.end_of_week.to_formatted_s(:rfc822)
        return a+b+c+d+e
      elsif foo== -1
        a = "Mon "
        b = (kpi.period).prev_week.to_formatted_s(:short)
        c = " to "
        d = " Sun "
        e = (kpi.period).prev_week.end_of_week.to_formatted_s(:rfc822)
        return a+b+c+d+e
      else
        return "something went wrong"
      end
    elsif kpi.kpiset.updatefreq == "Biweekly"
      if foo==0
        a = "Mon "
        b = (kpi.period).to_formatted_s(:short)
        c = " to "
        d = " Sun "
        e = (kpi.period).next_week.end_of_week.to_formatted_s(:rfc822)
        return a+b+c+d+e
      elsif foo==1
        a = "Mon "
        b = (kpi.period).next_week.next_week.to_formatted_s(:short)
        c = " to "
        d = " Sun "
        e = (kpi.period).next_week.next_week.next_week.end_of_week.to_formatted_s(:rfc822)
        return a+b+c+d+e
      elsif foo==-1
        a = "Mon "
        b = (kpi.period).prev_week.prev_week.to_formatted_s(:short)
        c = " to "
        d = " Sun "
        e = (kpi.period).prev_week.end_of_week.to_formatted_s(:rfc822)
        return a+b+c+d+e
      else
        return "something went wrong in Biweekly view"
      end
  elsif kpi.kpiset.updatefreq == "Monthly"
    if foo==0
      return kpi.period.to_formatted_s(:month_and_year)
    elsif foo==1
      return (kpi.period>>1).to_formatted_s(:month_and_year)
    elsif foo==-1
      return (kpi.period<<1).to_formatted_s(:month_and_year)
    else
      return "something went wrong in Monthly view"
    end
  elsif kpi.kpiset.updatefreq == "Bimonthly"
    if foo==0
        a = (kpi.period).strftime("%B")
        b = "-"
        c = (kpi.period>>1).to_formatted_s(:month_and_year)
        return a+b+c
      elsif foo==1
        a = (kpi.period>>3).strftime("%B")
        b = "-"
        c = (kpi.period>>4).to_formatted_s(:month_and_year)
        return a+b+c
      elsif foo==-1
        a = (kpi.period<<2).strftime("%B")
        b = "-"
        c = (kpi.period<<1).to_formatted_s(:month_and_year)
        return a+b+c
      else
      return "something went wrong in Bimonthly view"
    end
  elsif kpi.kpiset.updatefreq == "Quarterly"
    if foo==0
      a = ((kpi.period).at_beginning_of_quarter).strftime("%B")
        b = "-"
        c = (((kpi.period).at_beginning_of_quarter)>>2).to_formatted_s(:month_and_year)
        return a+b+c
      elsif foo==1
        a = ((kpi.period>>3).at_beginning_of_quarter).strftime("%B")
        b = "-"
        c = (((kpi.period).at_beginning_of_quarter)>>2).to_formatted_s(:month_and_year)
        return a+b+c
      elsif foo==-1
        a = ((kpi.period<<3).at_beginning_of_quarter).strftime("%B")
        b = "-"
        c = (((kpi.period).at_beginning_of_quarter)<<2).to_formatted_s(:month_and_year)
        return a+b+c
      else
        return "something went wrong in Quarterly view"
      end
  elsif kpi.kpiset.updatefreq == "Annual"
    if foo==0
      return (kpi.period).strftime("%Y")
    elsif foo==1
      return ((kpi.period).next_year).strftime("%Y")
    elsif foo==-1
      return ((kpi.period).prev_year).strftime("%Y")
    else
      return "something went wrong in annual"
    end
    else
      return "ble"
    end
   end

end
