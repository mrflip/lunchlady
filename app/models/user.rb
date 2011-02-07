class User < ActiveRecord::Base
  #
  # Attributes and scopes
  #
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :username, :is_local
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  #
  has_many :orders
  has_many :meals,      :through => :orders
  has_many :restaurants, :through => :orders
  #
  scope :local,          lambda{ where('(users.is_local IS NOT NULL)') }
  scope :alphabetically, order("users.name ASC")
  scope :by_id,          order("users.id ASC")

  #
  # Validations
  #
  validates :name,  :presence => true, :length => {:minimum => 1, :maximum => 100}

  #
  # Plugins
  #
  ajaxful_rater

  #
  # Methods
  #

  def self.orderers_for meal
    [local, all(:joins => :orders, :conditions => ['orders.meal_id = ?', meal.id])].flatten.uniq
  end

  def titleize
    name
  end

  def current_meal
    orders.first(:conditions => { :meal_id => Meal.current.id })
  end
end

# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  name                 :string(255)
#  username             :string(255)
#  is_local             :boolean
#

