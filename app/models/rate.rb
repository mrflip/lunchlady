class Rate < ActiveRecord::Base
  belongs_to :rater,     :class_name => "User"
  belongs_to :rateable,  :polymorphic => true

  scope :with_local_rater, joins(:rater).merge(User.local)
  attr_accessible :rate, :dimension
end
