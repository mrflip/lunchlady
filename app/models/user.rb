class User < ActiveRecord::Base
  #
  # Attributes and scopes
  #
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :username, :is_local, :shibboleth
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  #
  has_many :orders
  has_many :meals,      :through => :orders

  #
  scope :local,          lambda{ where(['users.is_local = ?', true]) }
  scope :alphabetically, order("users.name ASC")
  scope :by_id,          order("users.id ASC")

  #
  # Validations
  #
  validates :name,  :presence => true, :length => {:minimum => 1, :maximum => 100}

  # require users to know a magic watchword to register. Set this value in
  # config/app_config.yml or use an environment variable (on heroku, run
  #    heroku config:add SIGNUP_SHIBBOLETH=your_shibboleth
  #
  SIGNUP_SHIBBOLETH = ENV['SIGNUP_SHIBBOLETH'] || APP_CONFIG[:signup_shibboleth]
  validates_format_of :shibboleth, :with => /\A#{SIGNUP_SHIBBOLETH}\z/, :on => :create, :message => "is wrong. Lunchlady Doris frowns in your general direction. The right word, though, will endear you to the lunch lady and ensure some love with your chicken pot pie"

  #
  # Plugins
  #
  ajaxful_rater

  #
  # Methods
  #

  def self.orderers_for meal
    [local.by_id, all(:joins => :orders, :conditions => ['orders.meal_id = ?', meal.id])].flatten.uniq
  end

  def past_orders_for restaurant
    orders
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

