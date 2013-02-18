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

  def has_first?
    workshops.collect {|w| w.session}.include? 1
  end

  def has_second?
    workshops.collect {|w| w.session}.include? 2
  end

  def has_third?
    workshops.collect {|w| w.session}.include? 3
  end
  
  def signup(workshop)
    sessions = workshops.collect {|w| w.session}

    unless sessions.include? workshop.session
      workshop.teachers << self
      workshops << workshop
      return true
    else
      return false
    end
          
  end

  def done
    self.has_third? and self.has_second? and self.has_first?
  end

  def to_s
    name
  end
end
