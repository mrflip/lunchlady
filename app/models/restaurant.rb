class Restaurant < ActiveRecord::Base
  attr_accessible( :name, :phone, :address,
    :url, :menu_url, :inspection_url, :review_url,
    :delivers, :delivery_fee, :tip_percent, :discount_percent,
    :note)

  has_many :meals
  has_many :orders, :through => :meals
  has_many :rates, :as => 'rateable'

  scope :alphabetically, order("restaurants.name ASC")
  scope :by_all_rating,  order('restaurants.rating_average DESC')
  scope :by_user_rating, lambda{|u| includes('rates').where('rates.rater_id' => u).order('rates.stars DESC') }
  #
  # Plugins
  #
  has_friendly_id :name, :use_slug => true
  ajaxful_rateable :stars => 5

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
    weeks_existing = ((Date.today - self.created_at.to_date).to_f + 7) / 365.25
    (meals.count / weeks_existing).round
  end

  def avg_price
    orders.average(:price)
  end

  def lovers()      rates.where('stars = 5') ; end
  def lover_names() lovers.map(&:rater).compact.map(&:titleize).join(', ') ; end
  def loves()       lovers.present? ? lovers.count : ''  ; end

  def haters()      rates.where('stars = 1') ; end
  def hater_names() haters.map(&:rater).compact.map(&:titleize).join(', ') ; end
  def hates()       haters.present? ? haters.count : ''  ; end

  # Find previous orders from this restaurant;
  # * given user's orders first, most recent first;
  # * then other users' orders, most recent first
  def previous_order_descriptions(user)
    prev_orders   = orders.includes(:user).where(['users.is_local = ?', true]).order("(orders.user_id = #{user.id}) DESC, orders.user_id ASC, orders.created_at DESC")
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

