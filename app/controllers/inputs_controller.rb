class InputsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end 
  
  def create
    @input = current_user.inputs.build(params[:input])
    if @input.save
      flash[:success] = "Data Set created!"
      redirect_to :back
    else
      render 'static_pages/data'
      @feed_tests = [ ]
    end
  end

  def destroy
    Input.find(params[:id]).destroy
    redirect_to :back
  end

  private

    def correct_user
      @input = current_user.inputs.find_by_id(params[:id])
      redirect_to :back if @input.nil?
    end
  
end