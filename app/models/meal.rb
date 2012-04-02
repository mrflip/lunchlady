class Meal < ActiveRecord::Base
  attr_accessible :restaurant_id, :ordered_on, :done
  belongs_to      :restaurant
  has_many        :orders,   :dependent => :destroy, :order => :user_id
  has_many        :orderers, :through => :orders,    :source => :user

  validates :restaurant, :presence => true, :on => :update

  scope :by_recency,          order('ordered_on DESC')
  scope :recent_before_today, lambda{ by_recency.where(['ordered_on < ?', Date.today]) }
  scope :for_restaurant,      lambda{|r| where('restaurant_id = ?', (r.respond_to?(:id) ? r.id : r.to_i) ) }

  def self.for_date date_str
    date  = Chronic.parse(date_str).to_date
    order = find_or_create_by_ordered_on(date)
  end

  def order_for_user(user)
    return nil if user.blank?
    orders.for_user(user).first || orders.build(:user => user)
  end

  # @users.map{|user| @meal.order_for_user(user) }
  def expected_orders
    ords = orders.includes(:user)
    present_orderers = ords.map(&:user_id).to_set
    User.local.each{|u| ords << orders.build(:user => u) unless present_orderers.include?(u.id) }
    ords.sort_by{|o| [ (o.description.blank? ? 0 : 1 ), o.user_id ] }
  end

  def self.current
    for_date(Date.today)
  end

  def next_meal
    Meal.for_date(ordered_on + 1)
  end

  def prev_meal
    Meal.for_date(ordered_on - 1)
  end

  def self.upcoming(end_days=14)
    where(['ordered_on BETWEEN ? AND ?', 3.days.ago, end_days.days.from_now]).order('ordered_on ASC')
  end

  def titleize
    ordered_on.to_s(:verbose)
  end

  def restaurant_name
    restaurant ? restaurant.name : '(none yet)'
  end

  def day_name
    ordered_on.strftime("%A")
  end

  def to_param
    ordered_on_str
  end

  def ordered_on_str
    ordered_on.to_s
  end
end

# == Schema Information
#
# Table name: meals
#
#  id            :integer         not null, primary key
#  ordered_on    :date
#  restaurant_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#
