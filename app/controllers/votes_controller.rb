class VotesController < ApplicationController
  def create
    vote = Vote.new
    vote.user_id = session[:user_id]
    vote.work_id = params[:work_id]
    vote.save
    redirect_to work_path(params[:work_id])
  end
end
