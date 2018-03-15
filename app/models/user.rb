class User < ActiveRecord::Base
  has_and_belongs_to_many :workshops
  
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

  # Idea: move these settings to a new table
  def reg_time
    if self.role == "student"
      return Time.new(2018, 2, 26, 7, 45, 00, "-07:00") if self.special == "DAG"
      return Time.new(2018, 2, 26, 9, 30, 00, "-07:00") if self.year == 12
      return Time.new(2018, 2, 26, 14, 45, 00, "-07:00") if self.year == 11
      return Time.new(2018, 2, 27, 8, 0, 00, "-07:00") if self.year == 10
      return Time.new(2018, 2, 28, 9, 30, 00, "-07:00") if self.year == 9
    else
      return Time.new(2018, 2, 26, 9, 30, 00, "-07:00")
    end
  end
  
  def can_register
    return Time.now > self.reg_time
  end
  
end
