class Teacher < ActiveRecord::Base
  attr_accessible :number, :prefix, :email, :name
  validates :number, presence: true
  validates :prefix, presence: true
  validates :email, presence: true
  validates :name, presence: true
  validates :prefix, uniqueness: true

  has_and_belongs_to_many :workshops, uniq: true
  
  def self.authenticate(number, prefix)
    where(number: number, prefix: prefix.downcase).first
  end

  def self.registered
    self.all.select {|t| t.done?}
  end

  def self.unregistered
    self.all.select {|t| !t.done?}    
  end

  def has_first?
    workshops.collect {|w| w.session}.include? 1
  end

  def first
    workshops.select {|w| w.session == 1}[0]
  end

  def has_second?
    workshops.collect {|w| w.session}.include? 2
  end

  def second
    workshops.select {|w| w.session == 2}[0]
  end

  def has_third?
    workshops.collect {|w| w.session}.include? 3
  end
  
  def third
    workshops.select {|w| w.session == 3}[0]
  end
  def force(workshop_id)
    workshop = Workshop.find(workshop_id)
    workshop.teachers << self
    workshops << workshop
    workshop.ttaken += 1
    workshop.save!
  end

  def signup(workshop_id)
    workshop = Workshop.find(workshop_id)
    sessions = workshops.collect {|w| w.session}
    
    unless (whynot = workshop.cantSignUp self)
      workshop.teachers << self
      workshops << workshop
      workshop.ttaken += 1
      workshop.save!
      return "Signed up"
    else
      return whynot
    end
  end

  def done?
    self.has_third? and self.has_second? and self.has_first?
  end

  def to_s
    name
  end
  
  def full
    name
  end
end
