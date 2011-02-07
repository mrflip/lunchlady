require File.dirname(__FILE__) + '/../spec_helper'

describe Order do
  it "should be valid" do
    Order.new.should be_valid
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

