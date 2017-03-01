class Student < ActiveRecord::Base
  attr_accessible :number, :full, :gender, :grade, :year, :email, :prefix, :rw, :rw_number, :rw_teacher, :advisement, :advisement_name
  validates :number, :full, :gender, :grade, :year, :email, :prefix, :rw, :rw_number, :rw_teacher, :advisement,  presence: true
  has_and_belongs_to_many :workshops,  uniq: true

  def self.authenticate(number, prefix)
    where(prefix: prefix.downcase, number: number).first
  end

  def self.boys
    where("gender = 'BD'")
  end

  def self.girls
    where("gender = 'GD'")
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

  #Force sign up. Does no checks
  def force(workshop_id)
    workshop = Workshop.find(workshop_id)
    workshop.students << self
    workshops << workshop
    workshop.staken += 1
    workshop.save!
  end

  #Regular sign up, checks before it confirms
  def signup(workshop_id)
    workshop = Workshop.find(workshop_id)
    puts "Signing up ", prefix, " for workshop", workshop_id 
    
    unless (whynot = workshop.cantSignUp self)
      workshops << workshop
      workshop.staken += 1
      workshop.save!
      
      # Something along these lines
      # If they've signed up for something that repeats
    if Workshop.repeats.include? workshop.name 
      sessions_needed.each do |s|
        #Something along the lines of 
        #TODO reserved_workshops <<  Workshop.leastFullOfSession s
        #Something that gets us a reference to that other 
        #workshop and makes it seem taken 
        #But doesn't confuse them with actual workshops
        reserved.staken += 1
        reserved.save!
      end
    end

      return "Signed up"
    else
      return whynot
    end
  end

  def unsignup(workshop_id)
    workshop = Workshop.find(workshop_id)
    puts "Unsigning ", prefix, "from workshop", workshop_id
    workshop.students.delete(self)
    workshops.delete(workshop)
    workshop.staken -= 1
    workshop.save!
  end
  def auto
    begin 
      unless has_first?
        # Give them the one with the lowest fullness (amount of people/amount of spots)
        miserables = Workshop.firstsAvailable(self).sort {|w, w2| w.sfullness <=> w2.sfullness}
        puts miserables
        signup miserables.first.id
      end
    rescue 
      puts "Unable to find First for #{prefix}"
    end

   begin 
      unless has_second?
        # Give them the one with the lowest fullness (amount of people/amount of spots)
        miserables = Workshop.secondsAvailable(self).sort {|w, w2| w.sfullness <=> w2.sfullness}
        puts miserables
        signup miserables.first.id
      end
    rescue 
      puts "Unable to find Second for #{prefix}"
    end

  begin 
      unless has_third?
        # Give them the one with the lowest fullness (amount of people/amount of spots)
        miserables = Workshop.thirdsAvailable(self).sort {|w, w2| w.sfullness <=> w2.sfullness}
        puts miserables
        signup miserables.first.id
      end
    rescue 
      puts "Unable to find Third for #{prefix}"
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
    sessions_needed.empty?
  end

  def to_s
    full
  end

  def finished_with_registration
    if (needed = sessions_needed).empty?
      return true
    elsif Workshop.firstsAvailable(self) and needed.include? 1
      return false
    elsif Workshop.secondsAvailable(self) and needed.include? 2
      return false
    else #Workshop.thirdsAvailable(self) and needed.include? 3
      return false
    end
  end
end
