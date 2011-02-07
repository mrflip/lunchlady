class MealsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_from_params, :only => [:show, :edit, :update, :destroy]

  def index
    @meals = Meal.by_recency
  end

  def show
    if @meal.restaurant
      @users  = User.orderers_for(@meal)
      @orders = @users.map{|user| @meal.orders.for_user(user).first || @meal.orders.build(:user_id => user.id) }
      render :action => 'show'
    else
      render :action => 'edit'
    end
  end

  def current
    @meal = Meal.current
  end

  def edit
  end

  def update
    @meal.attributes = params[:meal]
    if @meal.restaurant_id_changed? && (not @meal.orders.blank?)
      @meal.orders.each(&:destroy)
      flash[:alert] = "Removed all existing orders from this meal. Please have everyone re-place their order"
    end
    if @meal.save
      flash[:notice] = "Successfully updated meal."
      redirect_to @meal
    else
      render :action => 'edit'
    end
  end

  def destroy
    @meal.destroy
    flash[:notice] = "Successfully destroyed meal."
    redirect_to meals_url
  end

private

  def find_from_params
    @meal = Meal.for_date(params[:id])
  end
end
