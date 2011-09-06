class RestaurantSweeper < ActionController::Caching::Sweeper
  observe Restaurant

  def after_create(restaurant)
    expire_cache_for(restaurant)
  end

  def after_update(restaurant)
    expire_cache_for(restaurant)
  end

  def after_destroy(restaurant)
    expire_cache_for(restaurant)
  end

  def after_rate(restaurant)
    expire_cache_for(restaurant)
  end

  def expire_cache_for(restaurant)
    expire_fragment([restaurant, 'previous_orders', current_user.id])
  end
end

