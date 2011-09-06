class Restaurant < ActiveRecord::Base
  attr_accessible( :name, :phone, :address,
    :url, :menu_url, :inspection_url, :review_url,
    :delivers, :delivery_fee, :tip_percent, :discount_percent,
    :note)

  has_many :meals
  has_many :orders, :through => :meals

  # Plugins
  has_friendly_id :name, :use_slug => true, :cache_column => :cached_slug, :reserved_words => %w[rate rating edit new dump]
  ajaxful_rateable :stars => 5

  #
  # Scopes
  #

  scope :alphabetically,    order("restaurants.name ASC")
  scope :by_all_rating,     order('restaurants.rating_average DESC')
  scope :by_user_rating,    lambda{|u| includes('rates').where('rates.rater_id' => u).order('rates.stars DESC') }

  scope :with_local_raters,   joins(:raters).merge(User.local)
  scope :group_by_restaurant, lambda{ group(([:id] + Restaurant.new.attributes.keys).map{|k| "restaurants.#{k}" }.join(",")) }
  scope :by_love_count,       with_local_raters.group_by_restaurant.order('COUNT(rates.stars = 5) DESC')
  scope :by_hate_count,       with_local_raters.group_by_restaurant.order('COUNT(rates.stars = 1) DESC')

  scope :by_last_ordered,   includes(:meals ).group_by_restaurant.order('MAX(meals.ordered_on) DESC, restaurants.id ASC').joins(:meals)
  scope :by_avg_price,      includes(:orders).group_by_restaurant.order('AVG(orders.price)     DESC, restaurants.id ASC').joins(:orders)
  #
  # Methods
  #

  def titleize
    name
  end

  def delivers?
    delivers.present?
  end

  def last_ordered_on
    meal = meals.recent_before_today.first or return
    meal.ordered_on
  end

  def days_since_last_ordered
    last_ordered_on && (Date.today - last_ordered_on).to_i
  end

  def frequency
    return if meals.count == 0
    months_existing = ((Date.today - self.created_at.to_date).to_f + 7) / 30.25
    (meals.count / months_existing)
  end

  def avg_price
    orders.average(:price)
  end

  def meals_count_since(since)
    meals.where("ordered_on > ?", since.days.ago).count
  end

  RATING_THRESHOLD = 3.0

  class_attribute :exp_rate_yint  ; self.exp_rate_yint  = RATING_THRESHOLD
  class_attribute :exp_rate_slope ; self.exp_rate_slope = 1.8

  def uncool?
    ((raters.count >= 3) && (rate_average <= (0.9 * RATING_THRESHOLD)))
  end
  def self.awesome
    includes(:rates).all.reject(&:uncool?)
  end

  # from a fit to observed values of how often ordered vs. rating
  def expected_rate
    exp_rate_slope * (rate_average + (0.25*(lovers.count-haters.count)) - RATING_THRESHOLD)
  end

  def timeliness
    return @timeliness if @timeliness
    return if (name =~ /franklin.s/i) || (raters.count <= 1) || (rate_average <= RATING_THRESHOLD)
    rate_t90d = meals_count_since(90) / 3.0
    rate_t90d = 0.5 if rate_t90d < 0.5
    @timeliness = expected_rate / rate_t90d
  end
  def timeliness_str()  timeliness ? timeliness.round.to_s : '' ; end
  def timeliness_or_average() [ -(timeliness||0), rate_average] ; end

  def lovers()      rates.with_local_rater.where('stars = 5')   ; end
  def lover_names() lovers.map(&:rater).compact.map(&:titleize).join(', ') ; end
  def loves()       lovers.present? ? lovers.count : ''  ; end

  def haters()      rates.with_local_rater.where('stars = 1')    ; end
  def hater_names() haters.map(&:rater).compact.map(&:titleize).join(', ') ; end
  def hates()       haters.present? ? haters.count : ''  ; end

  # Find previous orders from this restaurant;
  # * given user's orders first, most recent first;
  # * then other users' orders, most recent first
  def previous_order_descriptions(user)
    prev_orders   = orders.includes(:user).sort_by_user(user).merge(User.local)
    descriptions  = [['', '--previous orders--', '']]
    descriptions += prev_orders.map{|o| [o.user.short_name, o.description[0..100].gsub(/[\r\n\t]+/, ' ').strip, "%.2f"%o.price].to_json }
    descriptions.uniq
  end
end

# == Schema Information
#
# Table name: restaurants
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  phone            :string(255)
#  url              :string(255)
#  menu_url         :string(255)
#  address          :text
#  note             :text
#  delivers         :boolean
#  delivery_fee     :float
#  tip_percent      :integer
#  discount_percent :integer
#  inspection_url   :string(255)
#  review_url       :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

