class Teacher < ActiveRecord::Base
  attr_accessible :number, :prefix, :email, :name
  validates :number, :prefix, :email, :division, :name, presence: true
  validates :prefix, uniqueness: true

  has_and_belongs_to_many :workshops, uniq: true

  def reg_time
    return Time.new(2018, 2, 26, 9, 30, 00, "-07:00")
  end

  def can_register
    return Time.now > reg_time
  end
  
  def self.boys
    where(division: "BD")
  end

  def self.girls
    where(division: "GD")
  end

  def self.authenticate(number, prefix)
    where(number: number, prefix: prefix.downcase).first
  end

  def self.registered
    self.all.select {|t| t.done?}
  end

  def self.unregistered
    self.all.select {|t| !(t.done?)}
  end

  def sessions_needed
    [1,2,3] - workshops.map(&:session)
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

  # DEPRECATED - use UserHelper#force_register instead
  def force(workshop_id)
    self.transaction do
      workshop = Workshop.find(workshop_id)
      workshops << workshop
      workshop.ttaken += 1
      workshop.save!
    end
  end

  # DEPRECATED - see UserHelper#sign_up_user
  def signup(workshop_id)
    self.transaction do
      workshop = Workshop.find(workshop_id)

      unless (whynot = workshop.cantSignUp self)
        # Don't double register
        # workshop.teachers << self
        workshops << workshop
        workshop.ttaken += 1
        workshop.save!
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
      workshop.teachers.delete(self)
      workshops.delete(workshop)
      workshop.ttaken -= 1
      workshop.save!
      self.save!
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
  
  def auto
    begin 
      unless has_first?
        # Give them the one with the lowest fullness (amount of people/amount of spots)
        miserables = Workshop.firstsAvailable(self).sort {|w, w2| w.tfullness <=> w2.tfullness}
        puts miserables
        signup miserables.first.id
      end
    rescue 
      puts "Unable to find First for #{prefix}"
    end

    begin 
      unless has_second?
        # Give them the one with the lowest fullness (amount of people/amount of spots)
        miserables = Workshop.secondsAvailable(self).sort {|w, w2| w.tfullness <=> w2.tfullness}
        puts miserables
        signup miserables.first.id
      end
    rescue 
      puts "Unable to find Second for #{prefix}"
    end

    begin 
      unless has_third?
        # Give them the one with the lowest fullness (amount of people/amount of spots)
        miserables = Workshop.thirdsAvailable(self).sort {|w, w2| w.tfullness <=> w2.tfullness}
        puts miserables
        signup miserables.first.id
      end
    rescue 
      puts "Unable to find Third for #{prefix}"
    end
  end
  
end
