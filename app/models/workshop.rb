class Workshop < ActiveRecord::Base
  attr_accessible :name, :presentor, :description, :session, :tlimit, :slimit, :room
  has_many :students
  has_many :teachers
  validates :name, presence: true
  validates :presentor, presence: true  
  validates :description, presence: true
  validates :session, presence: true
  validates :tlimit, presence: true
  validates :slimit, presence: true
  validates :room, presence: true

  def to_s
    name
  end
end
  
