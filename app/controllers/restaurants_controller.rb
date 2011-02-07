class RestaurantsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_from_params, :only => [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.alphabetically
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant])
    if @restaurant.save
      flash[:notice] = "Successfully created restaurant."
      redirect_to @restaurant
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @restaurant.update_attributes(params[:restaurant])
      flash[:notice] = "Successfully updated restaurant."
      redirect_to restaurant_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @restaurant.destroy
    flash[:notice] = "Successfully destroyed restaurant."
    redirect_to restaurants_url
  end

private

  def find_from_params
    @restaurant = Restaurant.find(params[:id])
  end
end
