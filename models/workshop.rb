class Workshop < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessor :name, :presenter, :description, :session, :tlimit, :slimit, :room, :ttaken, :staken, :percentage, :overflow, :twofer_ref

  # List of all workshops in first session
  # Deprecate in the near future
  def self.firsts
    self.where(:session => 1)
  end
  
  # List of all workshops in second session
  # Deprecate in the near future
  def self.seconds
    self.where(:session => 2)
  end
  
  # List of all workshops in third session
  # Deprecate in the near future
  def self.thirds
    self.where(:session => 3)
  end
  
  # Return list of workshops that are full
  # Do we need this?
  def self.full
    all.select {|w|w.full?}
  end

  # Returns list of available workshops for a user
  # Used to be `available?`
  def self.available(user)
    all.select {|w| !w.cantSignUp user}
  end

  # Like `available` but specify a session
  def self.available_for_from(user, session)
    self.where(:session => session).select {|w| !w.cantSignUp user}
  end 

  # List of available first-session workshops for a user
  # Deprecate in the near future
  def self.firstsAvailable(user)
    firsts.select {|w| !w.cantSignUp user}
  end

  # List of available second-session workshops for a user
  # Deprecate in the near future
  def self.secondsAvailable(user)
    seconds.select {|w| !w.cantSignUp user}
  end

  # List of available third-session workshops for a user
  # Deprecate in the near future
  def self.thirdsAvailable(user)
    thirds.select {|w| !w.cantSignUp user}
  end

  # List of all workshops sorted by STUDENT fullness
  def self.leastFullOfStudentsInSession(n)
    self.find_by_sql("SELECT * FROM workshops 
                     WHERE session = #{n} 
                     ORDER BY staken/slimit 
                     LIMIT 1")
  end

  # List of all workshops sorted by TEACHER fullness
  def self.leastFullOfTeachersInSession(n)
    self.find_by_sql("SELECT * FROM workshops 
                     WHERE session = #{n} 
                     ORDER BY ttaken/tlimit 
                     LIMIT 1")
  end

  # Names of workshops with more than one session
  # Do we need this?
  def self.repeats
    self.find_by_sql("SELECT name FROM workshops
                     GROUP BY 1
                     HAVING count(*) > 1").map(&:name)
  end

  # Begin instance methods
  
  #TODO Add how full of each class
  # possibly to store in the db
  #How full of students
  def sfullness
    staken.to_f/slimit.to_f
  end
  
  #How full of teachers
  def tfullness
    ttaken.to_f/tlimit.to_f
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

  # BD students enrolled
  def boys
    users.select {|s| s.division == "BD" && s.role == "student"}
  end

  # GD students enrolled
  def girls
    users.select {|s| s.division == "GD" && s.role == "student"}
  end

  # Check if workshop is full for a given role
  def full_for?(r)
    where(role: "student").count >= slimit if r == "student"
    where(role: "teacher").count >= tlimit if r == "teacher"
  end
  
  # We need to add grade limits in here; possibly modify so workshops
  # store whether they can have more of a year or gender
  # fetch instead of calculating
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
    
    if user.role == "teacher" and (ttaken.to_f < tlimit.to_f)
      return false
    end
    
    # You can't sign up for a workshop if it has a nonzero twofer_ref and the workshop it points to is in a session you already are signed up for
    return true if self.twofer_ref != 0 and not ( user.sessions_needed.include?(Workshop.find(self.twofer_ref).session) )
    
    if user.role == "student" and (staken.to_f < slimit.to_f)
      #if adding a boy doesn't push us over the percentage limit
      if user.division == "BD" and ((boys.count + 1)/slimit.to_f <= percentage.to_f/100.to_f)
        return false
      end
      #same with girls
      if user.division == "GD" and ((girls.count + 1)/slimit.to_f <= percentage.to_f/100.to_f)
        return false
      end
    end
    
    return "The workshop is full"
  end
  
end
