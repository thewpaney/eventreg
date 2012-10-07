class Event < ActiveRecord::Base
  attr_accessible :name, :capacity, :restrict
  validates :name, presence: true
  validates :capacity, numericality: {greater_than: 0, only_integer: true}
  validates :restrict, numericality: {greater_than_or_equal_to: 9, less_than_or_equal_to: 12, only_integer: true, allow_nil: true}
  has_many :users

  def available?
    users.count < capacity
  end

  def availability
    "#{users.count}/#{capacity}"
  end

  def to_s
    name
  end
end
