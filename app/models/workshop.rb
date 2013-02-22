class Workshop < ActiveRecord::Base
  attr_accessible :name, :presentor, :description, :session, :tlimit, :slimit, :room, :ttaken, :staken, :percentage
  validates :name, presence: true
  validates :presentor, presence: true  
  validates :session, presence: true
  validates :tlimit, presence: true
  validates :slimit, presence: true
  validates :room, presence: true

  has_and_belongs_to_many :students
  has_and_belongs_to_many :teachers

  def boys
    students.select {|s| s.gender == "BD"}
  end

  def girls
    students.select {|s| s.gender == "GD"}    
  end

  def cantSignUp(user)
    if user.workshops.count < 3
      if user.workshops.collect {|w| w.name}.include? name
        return "You can't sign up for a workshop twice"
      end
      if user.class == Teacher and (ttaken.to_f < tlimit.to_f)
        return false
      end
      if user.class == Student and (staken.to_f < slimit.to_f)
        if user.gender = "BD" and ((boys.count + 1)/slimit.to_f < percentage.to_f/100.to_f)
          return false
        end
        if user.gender = "GD" and ((girls.count + 1)/slimit.to_f < percentage.to_f/100.to_f)
          return false
        end
        return "The workshop is full"
      end
      return "The workshop is full"
    end
    return "You are already signed up for three workshops. How did you get here?"
  end
      
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
  
