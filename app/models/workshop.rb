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

  def self.firsts
    self.where(:session => 1)
  end

  def self.seconds
    self.where(:session => 2)
  end
    
  def self.thirds
    self.where(:session => 3)
  end

  def to_s
      
    name
  end
end
  
