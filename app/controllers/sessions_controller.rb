class SessionsController < ApplicationController

  def new
      render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      login(@user)
      flash[:messages] = ["Login was successful!"]
      redirect_to user_url(@user.id)
    else
      flash[:errors] = ["invalid credentials"]
      render :new
    end
  end

  def destroy
    logout
    flash[:messages] = ["Good riddance"]
    redirect_to new_session_url
  end


  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
