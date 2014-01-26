class UsersController < ApplicationController
 
  layout "registration"

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    @user.user_type = "user"

  	   if @user.save
         session[:user_id] = @user.id
  		    redirect_to root_path, :notice => "Signed Up!"
          UserMailer.registration_confirmation(@user).deliver
  	   else
		      render 'new'
	     end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
