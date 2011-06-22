class RestaurantsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_from_params, :only => [:show, :rate, :edit, :update, :destroy]
  before_filter :ensure_current_slug_url, :only => :show

  def index
    case params[:order].to_s
    when 'my_rating'  then @restaurants = Restaurant.by_user_rating(current_user.id)
    when 'all_rating' then @restaurants = Restaurant.by_all_rating
    when 'name'       then @restaurants = Restaurant.alphabetically
    when 'price'      then @restaurants = Restaurant.all.sort_by{|r| -(r.avg_price || 0) }
    when 'ago'        then @restaurants = Restaurant.all.sort_by{|r| -(r.days_since_last_ordered || 0) }
    when 'freq'       then @restaurants = Restaurant.all.sort_by{|r| -(r.frequency || 0) }
    else                   @restaurants = Restaurant.by_all_rating
    end
  end

  def show
  end

  def rate
    # update the rating
    @restaurant.rate(params[:stars], current_user, params[:dimension])
    # calculate new user figures
    user_rating_dom_id = @restaurant.wrapper_dom_id(params.merge(:show_user_rating => true, :current_user => current_user))
    user_rating        = @restaurant.rate_by(current_user, params[:dimension]).stars
    user_width         = (user_rating / @restaurant.class.max_stars.to_f) * 100
    # calculate new global figures
    all_average        = @restaurant.rate_average(true, params[:dimension])
    all_width          = (all_average / @restaurant.class.max_stars.to_f) * 100
    all_rating_dom_id  = @restaurant.wrapper_dom_id(params.merge(:show_user_rating => false))
    return_hsh = {
      :id      => user_rating_dom_id, :average => user_rating, :width => user_width,
    }
    render :json => return_hsh
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

  def ensure_current_slug_url
    redirect_to @restaurant, :status => :moved_permanently unless @restaurant.friendly_id_status.best?
  end
end
