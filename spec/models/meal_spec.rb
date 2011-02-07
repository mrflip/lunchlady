require File.dirname(__FILE__) + '/../spec_helper'

describe Meal do
  it "should be valid" do
    Meal.new.should be_valid
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

