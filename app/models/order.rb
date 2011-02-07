class Order < ActiveRecord::Base
  attr_accessible :user_id, :meal_id, :description, :price, :copay, :guest_of
  belongs_to :user
  belongs_to :meal

  validates :user_id,  :presence => true
  validates :meal_id,  :presence => true
  validates :price,    :presence => true, :numericality => true

  scope :for_user, lambda{|u| where('user_id = ?', (u.respond_to?(:id) ? u.id : u.to_i) ) }
  scope :for_meal, lambda{|m| where('meal_id = ?', m.id) }

  def self.for_meal_and_user meal, user
    for_user(user).for_meal(meal).first
  end

  def titleize
    "#{user && user.titleize} on #{meal && meal.titleize}"
  end
end
