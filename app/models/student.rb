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

  has_and_belongs_to_many :workshops

  def self.authenticate(number, prefix)
    where(prefix: prefix.downcase, number: number).first
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


  def signup(workshop_id)
    workshop = Workshop.find(workshop_id)
    sessions = workshops.collect {|w| w.session}

    unless sessions.include? workshop.session
      workshop.students << self
      workshops << workshop
      workshop.staken += 1
      workshop.save!
      return true
    else
      return false
    end
          
  end

  def has_second?
    workshops.collect {|w| w.session}.include? 1
  end

  def has_third?
    workshops.collect {|w| w.session}.include? 1
  end
  
  def done?
    self.has_third? and self.has_second? and self.has_first?
  end

  def to_s
    full
  end
end

  
  
