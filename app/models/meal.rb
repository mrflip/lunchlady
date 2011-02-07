class Meal < ActiveRecord::Base
  attr_accessible :restaurant_id, :ordered_on
  belongs_to      :restaurant
  has_many        :orders, :dependent => :destroy

  scope :by_recency, order('ordered_on DESC')

  def self.for_date date_str
    date  = Chronic.parse(date_str).to_date
    order = find_or_create_by_ordered_on(date)
  end

  def self.current
    for_date(Date.today)
  end

  def self.upcoming
    (0 .. 6).map{|offset| Meal.for_date(Date.today + offset) }
  end

  #
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

