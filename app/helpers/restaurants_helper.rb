module RestaurantsHelper

  def restaurant_links restaurant
    raw([ ["Site", restaurant.url], ["Review", restaurant.review_url], ["Menu", restaurant.menu_url]
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

  def timeliness_selector_text(restaurants)
    restaurants.sort_by(&:timeliness_or_average).
      map{|r| [ [r.timeliness_str, r.name].join(' '), r.id ] }
  end

  def restaurant_dump(restaurant)
    [
      "%-15s" % [ restaurant.name.to_s[0..14] ],
      "%7.2f" % [ restaurant.rate_average ],
      "%7.2f" % [ (restaurant.meals_count_since( 90) / 3.0) ],
      "%7.2f" % [ (restaurant.meals_count_since(150) / 5.0) ],
      restaurant.frequency ? "%7.2f" % [ restaurant.frequency ] : nil,
      restaurant.loves,
      restaurant.hates,
      restaurant.raters.count,
      restaurant.days_since_last_ordered,
      restaurant.timeliness && ("%7.2f" % [ restaurant.timeliness ]),
    ].join("\t")
  end
end
