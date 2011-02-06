require File.dirname(__FILE__) + '/../spec_helper'

describe Restaurant do
  it "should be valid" do
    Restaurant.new.should be_valid
  end
end
