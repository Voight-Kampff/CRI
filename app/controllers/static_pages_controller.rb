class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @input = current_user.inputs.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def data
    if signed_in?
      @input = current_user.inputs.build
      @users = User.paginate(page: params[:page])
      @feed_tests = current_user.input_feed.paginate(page: params[:page])
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
      @kpi = current_user.kpis.build
    end
  end
    
end
