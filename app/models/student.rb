class Student < ActiveRecord::Base
  attr_accessible :number, :last, :first, :full, :gender, :grade, :year, :email, :prefix, :rw, :rw_number, :rw_teacher, :advisement
  validates :number, presence: true
  validates :last, presence: true
  validates :first, presence: true
  validates :full, presence: true
  validates :gender, presence: true
  validates :grade, presence: true
  validates :year, presence: true  
  validates :email, presence: true
  validates :prefix, presence: true
  validates :rw, presence: true
  validates :rw_number, presence: true
  validates :rw_teacher, presence: true
  validates :advisement, presence: true

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
    full
  end
end

  
  
