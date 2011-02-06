class Order < ActiveRecord::Base
    attr_accessible :user_id, :order_id, :description, :price, :copay, :guest_of, :created_by
end
