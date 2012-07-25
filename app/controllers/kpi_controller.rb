class KpiController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy
  
  def create
    @kpi = current_user.kpis.build(params[:kpi])
    if @kpi.save
      flash[:success] = "KPI created!"
      redirect_to :back
    else
      render 'static_pages/kpi'
      @feed_tests = [ ]
    end
  end
  
  private

    def correct_user
      @kpi = current_user.kpi.find_by_id(params[:id])
      redirect_to :back if @input.nil?
    end
  
end