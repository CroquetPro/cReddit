class SessionsController < ApplicationController

  def new
    @email = ''
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:email], params[:password])
    if @user
      login!(@user)
      redirect_to subs_url
    else
      @email = params[:email]
      flash.now[:errors] = ['Incorrect email and/or password']
      render :new
    end
  end

  def destroy
    @user = current_user
    logout!(@user)
    redirect_to new_session_url
  end

end
