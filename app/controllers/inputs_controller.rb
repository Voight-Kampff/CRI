class InputsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  before_filter :admin_user,     only: [:edit, :update, :destroy]
  
  def create
    @input = Input.create(params[:input])
    if @input.save
      flash[:success] = "Data added!"
      redirect_to :back
    else
      render 'static_pages/data'
      @inputset = [ ]
    end
  end

  def edit
    @input = Input.find(params[:id])
    if @input.update_attributes(params[:inputs])
      flash[:success] = "Data Updated"
      redirect_to 'edit'
    else
      render 'edit'
    end
  end

  def update
    @input = Input.find(params[:id])
    if @input.update_attributes(params[:inputs])
      flash[:success] = "Data Updated"
      redirect_to 'edit'
    else
      render 'edit'
    end
  end 

  def destroy
    Input.find(params[:id]).destroy
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