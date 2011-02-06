class Meal < ActiveRecord::Base
    attr_accessible :ordered_on, :restaurant_id
end
