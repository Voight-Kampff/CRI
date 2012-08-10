class KpisetsController < ApplicationController
  before_filter :signed_in_user, only: [:followers]
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  before_filter :admin_user,     only: [:edit, :update, :destroy]
  
  def create
    @kpiset = current_user.kpisets.build(params[:kpiset])
    if @kpiset.save
      flash[:success] = "KPI Set created!"
      redirect_to :back
    else
      render 'static_pages/kpi'
      @feed_tests = [ ]
    end
  end

  def edit
    @kpiset = Kpiset.find(params[:id])
  end 

  def update
    @kpiset = Kpiset.find(params[:id])
    if @kpiset.update_attributes(params[:kpiset])
      flash[:success] = "KPI Set updated"
      redirect_to '/kpi/'
    else
      render 'edit'
    end
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def destroy
    @kpiset.destroy
    redirect_to :back
  end

  def followers
    @title = "Followers"
    @kpiset = Kpiset.find(params[:id])
    @kpisets = @kpiset.followers
    render 'show_follow'
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
