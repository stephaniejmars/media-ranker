class UsersController < ApplicationController

  def login_form
    @user = User.new
  end 

  def login 
  
    user = User.find_by(user_name: params[:user][:user_name])

    if user.nil? 
      #new user
      user = User.new(user_name: params[:user][:user_name])
      if ! user.save
        flash[:error] = "Unable to Login"
        redirect_to root_path
        return
      end
      flash[:welcome] = "Welcome #{user.user_name}"
    else
      #existing user 
      flash[:welcome] = "Welcome back #{user.user_name}"
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil 
        flash[:notice] = "Goodbye #{user.user_name}"
      else
        session[:user_id] = nil 
        flash[:notice] = "Error Unknown User"
      end 
    else
      flash[:error] = "You must be logged in to logout"
    end
    redirect_to root_path 
  end 

  def current
  end

end
