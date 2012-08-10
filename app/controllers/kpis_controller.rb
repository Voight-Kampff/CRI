class KpisController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  before_filter :admin_user,     only: [:edit, :update, :destroy]
  
  def index
    @users = User.paginate(page: params[:page])
  end 

  def create
    @kpi = current_user.kpis.build(params[:kpi])
    if @kpi.save
      flash[:success] = "KPI added!"
      redirect_to :back
    else
      render 'static_pages/kpi'
      @kpiset = [ ]
    end
  end

  def edit
  end

  def update
  end 

  def destroy
    Kpi.find(params[:id]).destroy
    redirect_to :back
  end

  private

    def correct_user
      @kpiset = current_user.kpisets.find_by_id(params[:id])
      redirect_to :back if @kpiset.nil?
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
  
end