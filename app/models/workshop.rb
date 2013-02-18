class Workshop < ActiveRecord::Base
  attr_accessible :name, :presentor, :description, :session, :tlimit, :slimit, :room
  validates :name, presence: true
  validates :presentor, presence: true  
  validates :description, presence: true
  validates :session, presence: true
  validates :tlimit, presence: true
  validates :slimit, presence: true
  validates :room, presence: true

  has_and_belongs_to_many :students
  has_and_belongs_to_many :teachers

  def to_s
    name
  end
end
  
