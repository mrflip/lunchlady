class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :username, :is_local

  has_many :orders
  has_many :meals,      :through => :orders
  has_many :restaurants, :through => :orders
  scope :local,          lambda{ where('(users.is_local IS NOT NULL)') }
  scope :alphabetically, order("users.name ASC")
  scope :by_id,          order("users.id ASC")

  validates :name,  :presence => true, :length => {:minimum => 1, :maximum => 100}

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
