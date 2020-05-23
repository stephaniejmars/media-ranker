class VotesController < ApplicationController
  def create
    if session[:user_id]
      
      vote = Vote.new
      vote.user_id = session[:user_id]
      vote.work_id = params[:work_id]
      vote.save
      redirect_to work_path(params[:work_id])
    else
      flash[:status] = :warning
      flash[:message] = "A problem occured: You must log in to do that"
      redirect_back(fallback_location: root_path)
      return
    end
  end
end
