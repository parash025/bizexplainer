class SessionsController < ApplicationController
  def create
    user = User.find_by_email params[:email]

    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url if user.user_type == 'user'
      redirect_to admin_url if user.user_type == 'admin'
    else
      flash[:error] = "Invalid Email and Password."
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged Out."
  end
end
