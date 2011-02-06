class OrdersController < ApplicationController
  before_filter :find_meal_from_params
  before_filter :find_from_params,         :only => [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  #
  # * If the user_id is given and that order exists, send to edit not new.
  # * If the current user's order exists, make sure they don't try to double-create one.
  #
  #
  def new
    if params[:user_id].present? && (@order = Order.for_meal_and_user(@meal, params[:user_id]))
      render :action => 'edit'
    else
      params[:user_id] ||= current_user.id if user_signed_in?
      @order = Order.new(params.merge :meal_id => @meal.id)
    end
  end

  def create
    @order = Order.new(params[:order])
    @order.meal_id    = @meal.id
    @order.created_by = current_user.id if current_user
    if @order.save
      flash[:notice] = "Successfully created order."
      redirect_to @meal
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    @order.attributes = params[:order]
    @order.created_by = current_user.id if current_user
    if @order.save
      flash[:notice] = "Successfully updated order."
      redirect_to order_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @order.destroy
    flash[:notice] = "Successfully destroyed order."
    redirect_to @meal
  end

private
  def find_meal_from_params
    @meal  = Meal.for_date(params[:meal_id])
  end
  def find_from_params
    @order = @meal.orders.find(params[:id])
  end
end
