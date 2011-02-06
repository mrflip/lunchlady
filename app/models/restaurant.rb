class Restaurant < ActiveRecord::Base
  attr_accessible :name, :phone, :url, :menu_url, :address, :note, :delivers, :delivery_fee, :tip_percent, :discount_percent, :inspection_url, :review_url

  scope :alphabetically, order("restaurants.name ASC")

  def titleize
    name
  end
end
