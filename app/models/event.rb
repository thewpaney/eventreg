class Event < ActiveRecord::Base
  attr_accessible :capacity, :name
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
