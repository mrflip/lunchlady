class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(params[:meal])
    if @meal.save
      flash[:notice] = "Successfully created meal."
      redirect_to @meal
    else
      render :action => 'new'
    end
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def update
    @meal = Meal.find(params[:id])
    if @meal.update_attributes(params[:meal])
      flash[:notice] = "Successfully updated meal."
      redirect_to meal_url
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
end
