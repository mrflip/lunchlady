class Order < ActiveRecord::Base
  attr_accessible :user, :user_id, :meal_id, :description, :price, :copay, :guest_of
  belongs_to :user
  belongs_to :meal
  has_one    :restaurant, :through => :meal

  validates :user_id,   :presence => true
  validates :meal_id,   :presence => true
  validates :price,     :presence => true, :numericality => true
  validates :user_id,   :uniqueness => {:scope => :meal_id, :message => "already has an order. Go back to the meal and hit 'edit order'" }

  scope :for_user,      lambda{|u| where('user_id = ?', (u.respond_to?(:id) ? u.id : u.to_i) ) }
  scope :for_meal,      lambda{|m| where('meal_id = ?', m.id) }
  scope :for_date,      lambda{|d| joins(:meal).where('meals.ordered_on = ?', d) }
  scope :recent_first,  lambda{    includes('meal').order('meals.ordered_on DESC') }

  scope :sort_by_user,  lambda{|u| order("(orders.user_id = #{u.id}) DESC, orders.user_id ASC, orders.created_at DESC") }

  def self.for_meal_and_user meal, user
    for_user(user).for_meal(meal).first
  end

  def titleize
    "#{user && user.titleize} on #{meal && meal.titleize}"
  end
end

# == Schema Information
#
# Table name: orders
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  meal_id     :integer
#  description :text
#  price       :float
#  copay       :float
#  guest_of    :integer
#  created_by  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

