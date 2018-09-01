class Student < ActiveRecord::Base
  attr_accessor :number, :full, :gender, :grade, :year, :email, :prefix, :rw, :rw_number, :rw_teacher, :advisement, :advisement_name, :special
  validates :number, :full, :gender, :grade, :year, :email, :prefix, :rw, :rw_number, :rw_teacher, :advisement, presence: true
  has_and_belongs_to_many :workshops,  uniq: true

  def self.authenticate(number, prefix)
    where(prefix: prefix.downcase, number: number).first
  end

  def reg_time
    return Time.new(2018, 2, 26, 7, 45, 00, "-07:00") if self.special == "DAG"
    return Time.new(2018, 2, 26, 9, 30, 00, "-07:00") if self.year == "12"
    return Time.new(2018, 2, 26, 14, 45, 00, "-07:00") if self.year == "11"
    return Time.new(2018, 2, 27, 8, 0, 00, "-07:00") if self.year == "10"
    return Time.new(2018, 2, 28, 9, 30, 00, "-07:00") if self.year == "9"
  end

  def can_register
    return Time.now > self.reg_time
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
  # DEPRECATED - use UserHelper#force_register
  def force(workshop_id)
    self.transaction do
      workshop = Workshop.find(workshop_id)
      workshops << workshop
      workshop.staken += 1
      workshop.save!
    end
  end

  #Regular sign up, checks before it confirms
  # DEPRECATED - see UserHelper#sign_up_user
  def signup(workshop_id)
    self.transaction do
      workshop = Workshop.find(workshop_id)
      puts "Signing up ", prefix, " for workshop", workshop_id

      unless (whynot = workshop.cantSignUp self)
        workshops << workshop
        workshop.staken += 1
        workshop.save!

        # Something along these lines
        # If they've signed up for something that repeats
        #if Workshop.repeats.include? workshop.name
        #  sessions_needed.each do |s|
        #Something along the lines of
        #TODO reserved_workshops <<  Workshop.leastFullOfSession s
        #Something that gets us a reference to that other
        #workshop and makes it seem taken
        #But doesn't confuse them with actual workshops
        #  reserved.staken += 1
        #  reserved.save!
        #end

        # How about this instead
        if workshop.twofer_ref != 0
          twin = Workshop.find(workshop.twofer_ref)
          workshops << twin
          twin.staken += 1
          twin.save!
        end

        return "Signed up"
      else
        return whynot
      end
    end
  end

  def unsignup(workshop_id)
    self.transaction do
      workshop = Workshop.find(workshop_id)
      puts "Unsigning ", prefix, "from workshop", workshop_id
      workshop.students.delete(self)
      workshops.delete(workshop)
      workshop.staken -= 1
      workshop.save!
      self.save!
    end
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

  def finished_with_registration?
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
