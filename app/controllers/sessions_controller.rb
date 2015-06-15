class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    user_params = params.require(:user).permit(:email, :password)
    @user = User.confirm(user_params)
    if @user.save
      login(@user)
        flash[:success] = "Welcome to the blog app"
      redirect_to "/users/#{@user.id}"
    else
      redirect_to "/login"
    end
  end

  def destroy
    logout
    redirect_to "/index"
  end
end
