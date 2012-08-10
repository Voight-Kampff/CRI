class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.assigned_inputset_feed.paginate(page: params[:page])
    end
  end
  
  def data
    if signed_in?
      @input = Input.new
      @inputset = current_user.inputsets.build
      
      #@users = User.paginate(page: params[:page])
      #@intput_item = current_user.input_feed.paginate(page: params[:page])
    end
  end
  
  def help
  end

  def about
  end

  def contact
  end
  
  def kpi
    if signed_in?
      @kpi = Kpi.new
      @kpiset = current_user.kpisets.build
    end
  end
    
end
