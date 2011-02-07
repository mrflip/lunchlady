module RestaurantsHelper

  def restaurant_links restaurant
    raw([ ["Site", restaurant.url], ["Menu", restaurant.menu_url], ["Review", restaurant.review_url]
    ].map{|t,l| link_to(t, l, :target => 'lunchlady_popup') if l.present? }.compact.join(" &middot; "))
  end

  def delivery_status restaurant, str="Delivers"
    return "" unless restaurant.delivers?
    fee = (restaurant.delivery_fee.to_f == 0 ? '' : '('+number_to_currency(restaurant.delivery_fee.to_f)+')')
    "#{str} #{fee}"
  end

  def last_ordered_ago restaurant
    ordered_on_date = restaurant.last_ordered_on or return "--"
    "#{time_ago_in_words(ordered_on_date)} ago"
  end
end
