class Teacher < ActiveRecord::Base
  attr_accessible :number, :prefix, :email, :name
  validates :number, presence: true
  validates :prefix, presence: true
  validates :email, presence: true
  validates :name, presence: true

  validates :prefix, uniqueness: true
  has_and_belongs_to_many :workshops
  
  def self.authenticate(number, prefix)
    where(number: number, prefix: prefix.downcase).first
  end

  def self.registered
    where('workshop_id IS NOT NULL')
  end

  def self.unregistered
    where('workshop_id IS NULL')
  end
  
  def to_s
    name
  end
end
