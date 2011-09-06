class OrderSweeper < ActionController::Caching::Sweeper
  observe Order

  def after_create(order)
    expire_cache_for(order)
  end

  def after_update(order)
    expire_cache_for(order)
  end

  def after_destroy(order)
    expire_cache_for(order)
  end

  def after_rate(order)
    expire_cache_for(order)
  end

  def expire_cache_for(order)
    expire_fragment([order.restaurant, 'previous_orders', current_user.id])
  end
end

