class Order < ActiveRecord::Base
  attr_accessible :user_id, :meal_id, :description, :price, :copay, :guest_of, :created_by
  belongs_to :user
  belongs_to :meal

  validates :user_id,  :presence => true
  validates :meal_id,  :presence => true
  validates :price,    :presence => true, :numericality => true

  scope :for_user, lambda{|u| where('user_id = ?', u.id) }
end
