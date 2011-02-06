require File.dirname(__FILE__) + '/../spec_helper'

describe Order do
  it "should be valid" do
    Order.new.should be_valid
  end
end
