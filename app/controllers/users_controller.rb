class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    if !current_user || current_user.id != params[:id].to_i
      redirect_to new_user_url
    else
      @user = User.find(params[:id])
      render :show
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
