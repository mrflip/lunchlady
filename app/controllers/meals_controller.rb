class MealsController < ApplicationController
  before_filter :find_from_params, :only => [:show, :edit, :update, :destroy]

  def index
    @meals = Meal.by_recency
  end

  def show
    if @meal.restaurant
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
    @meal = Meal.find(params[:id])
    @meal.destroy
    flash[:notice] = "Successfully destroyed meal."
    redirect_to meals_url
  end

private

  def find_from_params
    @meal = Meal.for_date(params[:id])
  end
end
