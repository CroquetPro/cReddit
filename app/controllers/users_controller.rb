class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      flash[:notice] = ["Successfully registered #{@user.email}"]
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find_by_credentials(email, password)
    if @user.destroy
      flash[:notice] = ["Successfully deleted #{@user.email}."]
      redirect_to new_session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      redirect_to subs_url
    end
  end

  def user_params
    params.require(:user).permit(:email, :user_name, :password)
  end

end
