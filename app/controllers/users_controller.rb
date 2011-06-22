class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    case params[:order].to_s
    when 'id'     then @users = User.by_id
    when 'name'   then @users = User.alphabetically
    when 'usage'  then @users = User.by_usage
    else               @users = User.by_usage
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
