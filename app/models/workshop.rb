class Workshop < ActiveRecord::Base
  attr_accessible :name, :presentor, :description, :session, :tlimit, :slimit, :room, :ttaken, :staken, :percentage
  validates :name, presence: true
  validates :presentor, presence: true  
  validates :session, presence: true
  validates :tlimit, presence: true
  validates :slimit, presence: true
  validates :room, presence: true

  has_and_belongs_to_many :students, uniq: true
  has_and_belongs_to_many :teachers, uniq: true

  def sfullness
    staken.to_f/slimit.to_f
  end

  def tfullness
    ttaken.to_f/tlimit.to_f
  end

  def self.full
    all.select {|w|w.full?}
  end

  def self.available?(user)
    all.select {|w| !w.cantSignUp user}
  end

  def self.firstsAvailable(user)
    firsts.select {|w| !w.cantSignUp user}
  end

  def self.secondsAvailable(user)
    seconds.select {|w| !w.cantSignUp user}
  end

  def self.thirdsAvailable(user)
    thirds.select {|w| !w.cantSignUp user}
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
    "#{name}:#{session}"
  end

  def student_percentage_taken
    staken.to_f/slimit.to_f
  end

  def teacher_percentage_taken
    ttaken.to_f/tlimit.to_f
  end

  def boys
    students.select {|s| s.gender == "BD"}
  end

  def girls
    students.select {|s| s.gender == "GD"}    
  end

  def full?
    students.count >= slimit.to_i
  end

  def cantSignUp(user)
    if user.workshops.count > 3
      logger.error "User #{user.to_s} has more than three workshops, and requested workshop #{to_s}\n#{user.to_yaml}\n#{user.workshops}"
      return "You have more than three workshops."
    end

    if user.workshops.count == 3
      logger.error "User #{user.to_s} was able to request a workshop #{to_s} with three workshops\n#{user.to_yaml}\n#{user.workshops}"
      return "You are already signed up for three workshops."
    end

    if user.workshops.collect {|w| w.session}.include? session
      logger.error "User #{user.to_s} was able to request multiple workshops in a session, #{to_s}\n#{user.to_yaml}#{user.workshops}"
      return "You can't have more than one workshop in a session"
    end

    if user.workshops.collect {|w| w.name}.include? name
      return "You can't sign up for a workshop twice"
    end

    if user.class == Teacher and (ttaken.to_f < tlimit.to_f)
      return false
    end

    if user.class == Student and (staken.to_f < slimit.to_f)
      #if adding a boy doesn't push us over the percentage limit
      if user.gender == "BD" and ((boys.count + 1)/slimit.to_f <= percentage.to_f/100.to_f)
        return false
      end
      #same with girls
      if user.gender == "GD" and ((girls.count + 1)/slimit.to_f <= percentage.to_f/100.to_f)
        return false
      end
    end

    return "The workshop is full"
  end
end
