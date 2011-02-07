class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.by_id
  end

  def show
    @user = User.find(params[:id])
  end
end
