class UsersController < ApplicationController
  protect_from_forgery except: :search

  def new
  end

  def create
  end

  def search
    render json: User.search_with(Regexp.new("^#{params[:query].capitalize}.*"))
  end
end
