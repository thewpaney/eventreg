class Student < ActiveRecord::Base
  attr_accessible :number, :full, :gender, :grade, :year, :email, :prefix, :rw, :rw_number, :rw_teacher, :advisement
  validates :number, presence: true
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

  has_and_belongs_to_many :workshops, uniq: true

  def self.count_registered
    return where()
  end

  def self.authenticate(number, prefix)
    where(prefix: prefix.downcase, number: number).first
  end

  def self.boys
    where("gender IS 'BD'")
  end
  def self.girls
    where("gender IS 'GD'")
  end
  
  def self.registered
    where('workshop_id IS NOT NULL')
  end

  def self.unregistered
    where('workshop_id IS NULL')
  end

  def signup(workshop_id)
    workshop = Workshop.find(workshop_id)
    sessions = workshops.collect {|w| w.session}
    
    unless (whynot = workshop.cantSignUp self)
      workshop.students << self
      workshops << workshop
      workshop.staken += 1
      workshop.save!
      return "Signed up"
    else
      return whynot
    end
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
  def done?
    self.has_third? and self.has_second? and self.has_first?
  end

  def to_s
    full
  end
end

  
  
