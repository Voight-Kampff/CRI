class RelationshipsController < ApplicationController
  before_filter :signed_in_user


  def create
    @kpiset = Kpiset.find(params[:relationship][:followed_id])
    current_user.follow!(@kpiset)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def destroy
    @kpiset = Relationship.find(params[:id]).followed
    current_user.unfollow!(@kpiset)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

end