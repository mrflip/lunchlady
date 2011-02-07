module RestaurantsHelper

  def restaurant_links restaurant
    raw([ ["Homepage", @restaurant.url], ["Menu", @restaurant.menu_url], ["Review", @restaurant.review_url]
    ].map{|t,l| link_to(t, l) if l.present? }.compact.join(" &middot; "))
  end

  def delivery_status restaurant
    return "" unless restaurant.delivers?
    fee = (restaurant.delivery_fee.to_f == 0 ? 'free' : number_to_currency(restaurant.delivery_fee.to_f))
    "Delivers (#{fee})"
  end
end
