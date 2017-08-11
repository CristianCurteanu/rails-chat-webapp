class UsersController < ApplicationController
  protect_from_forgery except: :search

  def new
    @user = User.new
  end

  def create
    @user ||= User.new(registration_params)
    return redirect_to(login_path) if @user.save
    render :new
  end

  def search
    render json: User.search_with(Regexp.new("^#{params[:query].capitalize}.*"))
  end

  private

  def registration_params
    params.require(:user)
          .permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
