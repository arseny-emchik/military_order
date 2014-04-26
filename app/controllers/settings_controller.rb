class SettingsController < ApplicationController

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = user_params
    if @user.save
      redirect_to settings_path
    else
      render action: edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to settings_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :admin, :member)
  end

  def initialize_for_layout
    @current_tab = :settings
  end
end