class User < ActiveRecord::Base
  has_and_belongs_to_many :workshops
  attr_accessor :number, :full, :division, :year, :email, :prefix, :rw, :rw_number, :rw_teacher, :advisement, :advisement_name, :special, :role
  
  def self.authenticate(p, n)
    u = User.where(prefix: p, number: n).first
    return u.id unless u.nil?
  end
  
  def self.boys
    where("division = 'BD'")
  end
  
  def self.girls
    where("division = 'GD'")
  end

  def self.students
    where("role = 'student'");
  end

  def self.teachers
    where("role = 'teacher'");
  end
  
  def self.registered
    self.all.select {|s| s.done?}
  end
  
  def self.unregistered
    self.all.select {|s| !(s.done?)}
  end
  
  def sessions_needed
    [1,2,3] - workshops.map(&:session)
  end

  def done?
    sessions_needed.empty?
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
  
  def to_s
    full
  end
  
end
