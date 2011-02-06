require File.dirname(__FILE__) + '/../spec_helper'

describe Meal do
  it "should be valid" do
    Meal.new.should be_valid
  end
end
