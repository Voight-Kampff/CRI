class InputsetsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  before_filter :admin_user,     only: [:edit, :update, :destroy]
  
  def create
    @inputset = current_user.inputsets.build(params[:inputset])
    if @inputset.save
      flash[:success] = "Data Set created!"
      redirect_to :back
    else
      render 'static_pages/data'
      @feed_tests = [ ]
    end
  end

  def edit
    @inputset = Inputset.find(params[:id])
  end 

  def update
    @inputset = Inputset.find(params[:id])
    if @inputset.update_attributes(params[:inputset])
      flash[:success] = "Data Set updated"
      redirect_to '/data/'
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
    @inputset.destroy
    redirect_to :back
  end

private

    def correct_user
      @inputset = current_user.inputsets.find_by_id(params[:id])
      redirect_to :back if @inputset.nil?
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

end
